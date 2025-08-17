import 'dart:async';

import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/route_item_model.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/saved_places/saved_places_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/add_trip_route_fields_widget.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/add_trip_saved_places_widget.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/driver_selection_widget.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_monitoring_dialog.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/user_info_form_widget.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/directions_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddTripPage extends ConsumerStatefulWidget {
  const AddTripPage({super.key});

  @override
  ConsumerState<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends ConsumerState<AddTripPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  // Map related variables
  LatLng? pickLocation;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(33.8869, 9.5375), // Tunisia coordinates
    zoom: 6,
  );

  Position? userCurrentPosition;
  bool isFirstLoading = true;
  String? currentLocationName;

  // Route related variables
  List<RouteItemModel> routeItems = [];
  String? activeSearchField;
  int? activeFieldIndex;
  bool isMapSelectionMode = false;

  // User form variables
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // Driver selection
  UserModel? selectedDriver;
  bool showDriverSelection = false;
  List<UserModel> nearbyDrivers = [];

  // Trip details
  bool isStopoverEnabled = false;
  String selectedPaymentMethod = 'cash';
  double estimatedFare = 0.0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(tripsNotifierProvider.notifier).initDropOffLocation();
      setState(() {
        isLoading = true;
      });

      await ref.read(savedPlacesProvider.notifier).getAllSavedPlaces();
      setState(() {
        isLoading = false;
      });
    });
    _initializeRouteItems();
    _checkLocationPermission();
  }

  void _initializeRouteItems() {
    routeItems.add(RouteItemModel(
      id: "pickup",
      hint: "Pickup Location",
      prefillText: false,
    ));
    routeItems.add(RouteItemModel(
      id: "destination",
      hint: "Destination",
      prefillText: false,
    ));
  }

  Future<void> _checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        await _initializeLocation();
      } else {
        setState(() {
          isFirstLoading = false;
        });
      }
    } catch (e) {
      print("Error checking location permission: $e");
      setState(() {
        isFirstLoading = false;
      });
    }
  }

  Future<void> _calculateRouteAndUpdatePricing() async {
    final tripsState = ref.read(tripsNotifierProvider);

    // Only calculate if we have both pickup and at least one destination
    if (tripsState.userPickupLocation == null ||
        tripsState.userDropOffLocations.isEmpty ||
        tripsState.userDropOffLocations.first.locationLatitude == null) {
      return;
    }

    try {
      // Reset totals
      ref.read(tripsNotifierProvider.notifier).resetTotalDistanceMeters();
      ref.read(tripsNotifierProvider.notifier).resetTotalDurationSeconds();

      // Build route points
      final List<LatLng> allPoints = [
        LatLng(
          tripsState.userPickupLocation!.locationLatitude!,
          tripsState.userPickupLocation!.locationLongitude!,
        ),
        ...tripsState.userDropOffLocations
            .where((e) =>
                e.locationLatitude != null && e.locationLongitude != null)
            .map((e) => LatLng(e.locationLatitude!, e.locationLongitude!)),
      ];

      // Need at least pickup and one destination
      if (allPoints.length < 2) return;

      // Calculate distance and duration for each segment
      for (int i = 0; i < allPoints.length - 1; i++) {
        final originLatLng = allPoints[i];
        final destinationLatLng = allPoints[i + 1];

        final result = await ref
            .read(tripsNotifierProvider.notifier)
            .obtainOriginToDestinationDirectionDetails(
              originLatLng.latitude,
              originLatLng.longitude,
              destinationLatLng.latitude,
              destinationLatLng.longitude,
            );

        if (result != null) {
          ref
              .read(tripsNotifierProvider.notifier)
              .updateTotalDistanceMeters(result.distanceValue!);
          ref
              .read(tripsNotifierProvider.notifier)
              .updateTotalDurationSeconds(result.durationValue!);
        }
      }

      // Now update pricing for all drivers
      setState(() {
        if (nearbyDrivers.isNotEmpty && selectedDriver != null) {
          estimatedFare = _calculateDriverFare(selectedDriver!);
        } else if (nearbyDrivers.isNotEmpty) {
          // Set estimated fare to first driver's fare
          estimatedFare = _calculateDriverFare(nearbyDrivers.first);
        }
      });

      print(
          "Route calculated - Distance: ${ref.read(tripsNotifierProvider).totalDistanceMeters}m, Duration: ${ref.read(tripsNotifierProvider).totalDurationSeconds}s");
    } catch (e) {
      print("Error calculating route: $e");
    }
  }

  Future<void> _initializeLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isFirstLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userCurrentPosition = position;

      LatLng latLngPosition = LatLng(position.latitude, position.longitude);
      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 15);

      if (newGoogleMapController != null) {
        await newGoogleMapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }

      setState(() {
        isFirstLoading = false;
      });
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        isFirstLoading = false;
      });
    }
  }

  Future<void> _fetchAddressFromLatLng({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final address =
          await ref.read(tripsNotifierProvider.notifier).fetchAddressFromLatLng(
                latitude: latitude,
                longitude: longitude,
                context: context,
              );

      setState(() {
        currentLocationName = address;
      });
    } catch (e) {
      print("Error fetching address: $e");
      setState(() {
        currentLocationName = "Unknown Location";
      });
    }
  }

  void _onFieldTap(String fieldId, int index) {
    setState(() {
      activeSearchField = fieldId;
      activeFieldIndex = index;
      isMapSelectionMode = true;
    });
  }

  void _onFieldChanged(String fieldId, String value) {
    setState(() {
      activeSearchField = fieldId;
    });

    // Implement search functionality
    if (value.length > 2 && userCurrentPosition != null) {
      _performSearch(value);
    }
  }

  Future<void> _performSearch(String query) async {
    try {
      await ref.read(tripsNotifierProvider.notifier).searchAddressAutoComplete(
            inputText: query,
            userLat: userCurrentPosition?.latitude ?? 33.8869,
            userLng: userCurrentPosition?.longitude ?? 9.5375,
          );
    } catch (e) {
      print("Error performing search: $e");
    }
  }

  void _addStop() {
    final destinationIndex = routeItems.length - 1;
    setState(() {
      routeItems.insert(
        destinationIndex,
        RouteItemModel(
          id: "stop_${DateTime.now().millisecondsSinceEpoch}",
          hint: "Add Stop",
          prefillText: false,
        ),
      );
    });
    ref
        .read(tripsNotifierProvider.notifier)
        .addDropOffLocation(const DirectionsModel());
  }

  void _confirm() {
    _calculateRouteAndUpdatePricing();
  }

  void _removeStop(String id) {
    setState(() {
      final index = routeItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        routeItems[index].dispose();
        routeItems.removeAt(index);
        ref
            .read(tripsNotifierProvider.notifier)
            .deleteDropOffLocationAt(index - 1);

        // Recalculate pricing if destinations change
        _calculateRouteAndUpdatePricing();
      }
    });
  }

  void _swapRouteAndDestination() {
    if (routeItems.length >= 2) {
      ref.read(tripsNotifierProvider.notifier).swapDropOffAndPickupLocation();
      setState(() {
        final temp = routeItems[0];
        routeItems[0] =
            routeItems[routeItems.length - 1].copyWith(id: "pickup");
        routeItems[routeItems.length - 1] = temp.copyWith(id: "destination");
      });
    }
  }

  void _assignLocationToField() {
    if (activeSearchField != null &&
        pickLocation != null &&
        currentLocationName != null) {
      setState(() {
        final index =
            routeItems.indexWhere((item) => item.id == activeSearchField);
        if (index != -1) {
          routeItems[index] = routeItems[index].copyWith(
            controller: TextEditingController(text: currentLocationName!),
          );
        }
      });

      // Create DirectionsModel and update provider
      final directionsModel = DirectionsModel(
        locationName: currentLocationName,
        locationLatitude: pickLocation!.latitude,
        locationLongitude: pickLocation!.longitude,
        humanReadableAddress: currentLocationName,
      );

      // Update the appropriate location in provider
      if (activeSearchField == "pickup") {
        ref
            .read(tripsNotifierProvider.notifier)
            .updatePickupLocationAddress(directionsModel);

        // Fetch nearby drivers when pickup location is set
        _fetchNearbyDrivers();
      } else if (activeFieldIndex != null) {
        // For destination or stops
        final dropOffIndex =
            activeFieldIndex! - 1; // Subtract 1 because pickup is index 0
        if (dropOffIndex >= 0) {
          ref
              .read(tripsNotifierProvider.notifier)
              .updateDropOffLocationAddress(directionsModel, dropOffIndex);
        }
      }

      setState(() {
        isMapSelectionMode = false;
        activeSearchField = null;
        activeFieldIndex = null;
      });
    }
  }

  Future<void> _fetchNearbyDrivers() async {
    final tripsState = ref.read(tripsNotifierProvider);
    if (tripsState.userPickupLocation == null) return;

    setState(() {
      showDriverSelection = true;
    });

    try {
      // First calculate route distance and duration
      // await _calculateRouteDistanceAndDuration();

      // Then fetch nearby drivers
      final drivers = await ref
          .read(tripsNotifierProvider.notifier)
          .fetchNearbyDriversForLocation(
            latitude: tripsState.userPickupLocation!.locationLatitude!,
            longitude: tripsState.userPickupLocation!.locationLongitude!,
            radiusKm: 10.0,
          );

      setState(() {
        nearbyDrivers = drivers;
        // Calculate estimated fare based on route and first available driver
        if (drivers.isNotEmpty) {
          final firstDriver = drivers.first;
          estimatedFare = _calculateDriverFare(firstDriver);
        }
      });

      if (drivers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No drivers available in this area'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e, s) {
      print("Error fetching nearby drivers: $e,$s");
      setState(() {
        nearbyDrivers = [];
      });
    }
  }

  Future<void> _calculateRouteDistanceAndDuration() async {
    final tripsState = ref.read(tripsNotifierProvider);

    if (tripsState.userPickupLocation == null ||
        tripsState.userDropOffLocations.isEmpty) return;

    // Reset totals
    ref.read(tripsNotifierProvider.notifier).resetTotalDistanceMeters();
    ref.read(tripsNotifierProvider.notifier).resetTotalDurationSeconds();

    // Build route points
    final List<LatLng> allPoints = [
      LatLng(
        tripsState.userPickupLocation!.locationLatitude!,
        tripsState.userPickupLocation!.locationLongitude!,
      ),
      ...tripsState.userDropOffLocations
          .map((e) => LatLng(e.locationLatitude!, e.locationLongitude!)),
    ];

    // Calculate distance and duration for each segment
    for (int i = 0; i < allPoints.length - 1; i++) {
      final originLatLng = allPoints[i];
      final destinationLatLng = allPoints[i + 1];

      final result = await ref
          .read(tripsNotifierProvider.notifier)
          .obtainOriginToDestinationDirectionDetails(
            originLatLng.latitude,
            originLatLng.longitude,
            destinationLatLng.latitude,
            destinationLatLng.longitude,
          );

      if (result != null) {
        ref
            .read(tripsNotifierProvider.notifier)
            .updateTotalDistanceMeters(result.distanceValue!);
        ref
            .read(tripsNotifierProvider.notifier)
            .updateTotalDurationSeconds(result.durationValue!);
      }
    }
  }

  double _calculateDriverFare(UserModel driver) {
    final admin = ref.read(driversNotifierProvider).adminModel!;
    final tripsState = ref.read(tripsNotifierProvider);

    if (driver.driverInfo?.vehicleInfo.travelClass == null) {
      return 0.0;
    }

    final travelClass =
        driver.driverInfo!.vehicleInfo.travelClass.toLowerCase();

    if (travelClass == 'economic') {
      return calculateEconomicDisplayedPrice(
        tripsState.totalDistanceMeters,
        admin.kmPrice,
      );
    } else if (travelClass == 'luxury suv') {
      return calculateLuxurySuvPrice(
        distanceMeters: tripsState.totalDistanceMeters,
        kmPrice: admin.kmPrice,
        luxurySuvPercentage: admin.luxurySuvPricePercentage,
      );
    } else {
      // luxury or other premium classes
      return calculateLuxuryPrice(
        distanceMeters: tripsState.totalDistanceMeters,
        kmPrice: admin.kmPrice,
        luxuryPercentage: admin.luxuryPricePercentage,
      );
    }
  }

  List<UserModel> _getEconomicDrivers() {
    return nearbyDrivers
        .where((driver) =>
            driver.driverInfo?.vehicleInfo.travelClass?.toLowerCase() ==
            'economic')
        .toList();
  }

  List<UserModel> _getLuxuryDrivers() {
    return nearbyDrivers
        .where((driver) =>
            driver.driverInfo?.vehicleInfo.travelClass?.toLowerCase() !=
            'economic')
        .toList();
  }

  void _cancelMapSelection() {
    setState(() {
      isMapSelectionMode = false;
      activeSearchField = null;
      activeFieldIndex = null;
    });
  }

  UserModel _createUserModel() {
    return UserModel.createNew(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phone: _phoneController.text,
      email: _emailController.text.isEmpty ? null : _emailController.text,
    );
  }

  void _saveTrip() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required user information'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final tripsState = ref.read(tripsNotifierProvider);

    if (tripsState.userPickupLocation == null ||
        tripsState.userDropOffLocations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select pickup and destination locations'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedDriver == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a driver'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final user = _createUserModel();

      final trip = await ref.read(tripsNotifierProvider.notifier).createTrip(
            user: user,
            driver: selectedDriver!,
            fare: estimatedFare,
            paymentMethod: selectedPaymentMethod,
            isStopOver: isStopoverEnabled,
          );

      if (trip != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Trip created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Show monitoring dialog immediately after trip creation
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => TripMonitoringDialog(
            initialTrip: trip,
            showCloseButton: true,
            onClose: () {
              // Only reset form when trip is completed successfully
              // For rejected trips, we don't reset so agent can try another driver
              _resetForm();
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create trip'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating trip: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// Add this helper method to handle partial form reset for rejected trips
  void _handleTripRejection() {
    // Clear only driver selection, keep all other form data
    setState(() {
      selectedDriver = null;
      nearbyDrivers = []; // Clear the drivers list so agent can fetch new ones
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Driver declined. Please select another driver and try again.'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _emailController.clear();

    setState(() {
      selectedDriver = null;
      showDriverSelection = false;
      nearbyDrivers = [];
      isStopoverEnabled = false;
      selectedPaymentMethod = 'cash';
      estimatedFare = 0.0;
    });

    ref.read(tripsNotifierProvider.notifier).clearAddTripData();

    for (var item in routeItems) {
      item.controller?.clear();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    for (var item in routeItems) {
      item.dispose();
    }
    if (newGoogleMapController != null) {
      newGoogleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripsState = ref.watch(tripsNotifierProvider);
    final savedPlaces = ref.watch(savedPlacesProvider).savedPlaces ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CommonText.textBoldWeight600(
          text: "Create Agent Trip",
          fontSize: 20.sp,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.sp),
            child: CustomButtons.simpleButton(
              onPressed: tripsState.isCreatingTrip ? null : _saveTrip,
              text: tripsState.isCreatingTrip ? "Creating..." : "Create Trip",
              width: 120.w,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left side - Forms and trip details
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[50],
              padding: EdgeInsets.all(16.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Information Form
                    UserInfoFormWidget(
                      formKey: _formKey,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      phoneController: _phoneController,
                      emailController: _emailController,
                    ),

                    SizedBox(height: 24.sp),

                    // Route fields section
                    CommonText.textBoldWeight600(
                      text: "Trip Route",
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                    SizedBox(height: 16.sp),

                    AddTripRouteFieldsWidget(
                      routeItems: routeItems,
                      onFieldTap: _onFieldTap,
                      onFieldChanged: _onFieldChanged,
                      onAddStop: _addStop,
                      onRemoveStop: _removeStop,
                      onSwapRouteAndDestination: _swapRouteAndDestination,
                      confirm: _confirm,
                      activeField: activeSearchField,
                      searchResults: tripsState.searchResults,
                      onPlaceSelected: (place) {
                        if (activeSearchField != null) {
                          setState(() {
                            final index = routeItems.indexWhere(
                                (item) => item.id == activeSearchField);
                            if (index != -1) {
                              routeItems[index] = routeItems[index].copyWith(
                                controller: TextEditingController(
                                    text: place.mainText ?? ''),
                              );
                            }
                          });
                          // Create DirectionsModel from search result
                          final directionsModel = DirectionsModel(
                            locationName: place.mainText,
                            locationLatitude: place.latitude,
                            locationLongitude: place.longitude,
                            humanReadableAddress: place.mainText,
                            locationId: place.placeId,
                          );

                          // Update provider
                          if (activeSearchField == "pickup") {
                            ref
                                .read(tripsNotifierProvider.notifier)
                                .updatePickupLocationAddress(directionsModel);
                            _fetchNearbyDrivers();
                          } else if (activeFieldIndex != null) {
                            final dropOffIndex = activeFieldIndex! - 1;
                            if (dropOffIndex >= 0) {
                              ref
                                  .read(tripsNotifierProvider.notifier)
                                  .updateDropOffLocationAddress(
                                      directionsModel, dropOffIndex);
                              // Calculate route and update pricing when destination is set
                              _calculateRouteAndUpdatePricing();
                            }
                          }

                          setState(() {
                            isMapSelectionMode = false;
                            activeSearchField = null;
                            activeFieldIndex = null;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 20.sp),

                    // Map selection buttons
                    if (isMapSelectionMode) ...[
                      Container(
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWeight500(
                              text:
                                  "Select location on map for: $activeSearchField",
                              fontSize: 14.sp,
                              color: Colors.blue[700]!,
                            ),
                            SizedBox(height: 8.sp),
                            if (currentLocationName != null)
                              CommonText.textBoldWeight400(
                                text: currentLocationName!,
                                fontSize: 12.sp,
                                color: Colors.grey[600]!,
                              ),
                            SizedBox(height: 12.sp),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButtons.simpleButton(
                                    onPressed: _assignLocationToField,
                                    text: "Assign Location",
                                  ),
                                ),
                                SizedBox(width: 8.sp),
                                Expanded(
                                  child: CustomButtons.simpleButton(
                                    onPressed: _cancelMapSelection,
                                    text: "Cancel",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                    ],

                    // Driver Selection
                    if (showDriverSelection) ...[
                      DriverSelectionWidget(
                        nearbyDrivers: nearbyDrivers,
                        selectedDriver: selectedDriver,
                        onDriverSelected: (driver) {
                          setState(() {
                            selectedDriver = driver;
                            estimatedFare = _calculateDriverFare(driver);
                          });
                        },
                        isStopoverEnabled: isStopoverEnabled,
                        onStopoverChanged: (value) {
                          setState(() {
                            isStopoverEnabled = value;
                          });
                        },
                        selectedPaymentMethod: selectedPaymentMethod,
                        onPaymentMethodChanged: (method) {
                          setState(() {
                            selectedPaymentMethod = method;
                          });
                        },
                        estimatedFare: estimatedFare,
                        totalDistanceMeters:
                            ref.read(tripsNotifierProvider).totalDistanceMeters,
                        kmPrice: ref
                            .read(driversNotifierProvider)
                            .adminModel!
                            .kmPrice,
                        luxuryPercentage: ref
                            .read(driversNotifierProvider)
                            .adminModel!
                            .luxuryPricePercentage,
                        luxurySuvPercentage: ref
                            .read(driversNotifierProvider)
                            .adminModel!
                            .luxurySuvPricePercentage,
                      ),
                      SizedBox(height: 20.sp),
                    ],

                    // Saved places section
                    AddTripSavedPlacesWidget(
                      savedPlaces: savedPlaces,
                      onPlaceSelected: (place) {
                        if (activeSearchField != null) {
                          setState(() {
                            final index = routeItems.indexWhere(
                                (item) => item.id == activeSearchField);
                            if (index != -1) {
                              routeItems[index] = routeItems[index].copyWith(
                                controller:
                                    TextEditingController(text: place.label),
                              );
                            }
                          });
                          // Create DirectionsModel from saved place
                          final directionsModel = DirectionsModel(
                            locationName: place.label,
                            locationLatitude: place.latitude,
                            locationLongitude: place.longitude,
                            humanReadableAddress: place.subLabel,
                          );

                          // Update provider
                          if (activeSearchField == "pickup") {
                            ref
                                .read(tripsNotifierProvider.notifier)
                                .updatePickupLocationAddress(directionsModel);
                            _fetchNearbyDrivers();
                          } else if (activeFieldIndex != null) {
                            final dropOffIndex = activeFieldIndex! - 1;
                            if (dropOffIndex >= 0) {
                              ref
                                  .read(tripsNotifierProvider.notifier)
                                  .updateDropOffLocationAddress(
                                      directionsModel, dropOffIndex);
                              // Calculate route and update pricing when destination is set
                              _calculateRouteAndUpdatePricing();
                            }
                          }

                          setState(() {
                            isMapSelectionMode = false;
                            activeSearchField = null;
                            activeFieldIndex = null;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Right side - Map
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controllerGoogleMap.isCompleted) {
                        _controllerGoogleMap.complete(controller);
                        newGoogleMapController = controller;
                        _initializeLocation();
                      }
                    },
                    onCameraMove: (CameraPosition cameraPosition) {
                      if (pickLocation != cameraPosition.target) {
                        setState(() {
                          pickLocation = cameraPosition.target;
                        });
                      }
                    },
                    onCameraIdle: () async {
                      if (pickLocation != null && !isFirstLoading) {
                        await _fetchAddressFromLatLng(
                          latitude: pickLocation!.latitude,
                          longitude: pickLocation!.longitude,
                        );
                      }
                    },
                  ),

                  // Center pin
                  if (!isFirstLoading)
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isMapSelectionMode &&
                                currentLocationName != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.sp,
                                  vertical: 8.sp,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.sp),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: CommonText.textBoldWeight500(
                                  text: currentLocationName!,
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            SizedBox(height: 8.sp),
                            Assets.svgs.pin.svg(
                              height: 40.sp,
                              width: 40.sp,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // My location button
                  Positioned(
                    bottom: 20.sp,
                    right: 20.sp,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _initializeLocation,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.my_location),
                    ),
                  ),

                  // Loading indicator
                  if (isFirstLoading || tripsState.isFetchingAddress)
                    Container(
                      color: Colors.white.withOpacity(0.7),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            SizedBox(height: 16.sp),
                            CommonText.textBoldWeight500(
                              text: isFirstLoading
                                  ? "Loading map..."
                                  : "Getting address...",
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
