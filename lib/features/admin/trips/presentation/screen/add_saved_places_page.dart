import 'dart:async';

import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/saved_places/saved_places_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_provider.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/location_model.dart';
import 'package:fasti_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddSavedPlacePage extends ConsumerStatefulWidget {
  const AddSavedPlacePage({super.key});

  @override
  ConsumerState<AddSavedPlacePage> createState() => _AddSavedPlacePageState();
}

class _AddSavedPlacePageState extends ConsumerState<AddSavedPlacePage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  // Map related variables
  LatLng? selectedLocation;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(33.8869, 9.5375), // Tunisia coordinates
    zoom: 6,
  );

  Position? userCurrentPosition;
  bool isFirstLoading = true;
  String? currentLocationName;
  bool isFetchingAddress = false;
  bool isSaving = false;

  // Form variables
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _subLabelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
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
        selectedLocation = latLngPosition;
        isFirstLoading = false;
      });

      // Fetch address for current location
      await _fetchAddressFromLatLng(
        latitude: position.latitude,
        longitude: position.longitude,
      );
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
      setState(() {
        isFetchingAddress = true;
      });

      // Use the existing address fetching method from trips provider
      final address =
          await ref.read(tripsNotifierProvider.notifier).fetchAddressFromLatLng(
                latitude: latitude,
                longitude: longitude,
                context: context,
              );

      setState(() {
        currentLocationName = address;
        isFetchingAddress = false;
        // Auto-fill sub-label if it's empty

        _subLabelController.text = address;
      });
    } catch (e) {
      print("Error fetching address: $e");
      setState(() {
        currentLocationName = "Unknown Location";
        isFetchingAddress = false;
      });
    }
  }

  Future<void> _savePlaceToFirestore() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location on the map'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // Create LocationModel
      final locationModel = LocationModel(
        id: '',
        latitude: selectedLocation!.latitude,
        longitude: selectedLocation!.longitude,
        label: _labelController.text.trim(),
        subLabel: _subLabelController.text.trim(),
      );
      final result = await ref
          .read(savedPlacesProvider.notifier)
          .addSavedPlace(locationModel);
      if (result == true) {
        setState(() {
          isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved place added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _resetForm();
      } else {
        setState(() {
          isSaving = false;
        });
        throw Exception('Error saving place');
      }
    } catch (e) {
      setState(() {
        isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving place: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveLocationToFirestore(LocationModel location) async {
    // TODO: Implement actual Firestore save
    // For now, simulate a delay
    await Future.delayed(const Duration(seconds: 1));

    // You would typically do something like:
    // await FirebaseFirestore.instance
    //     .collection('saved_places')
    //     .add(location.toJson());
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _labelController.clear();
    _subLabelController.clear();
    setState(() {
      currentLocationName = null;
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    _subLabelController.dispose();
    if (newGoogleMapController != null) {
      newGoogleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CommonText.textBoldWeight600(
          text: "Add Saved Place",
          fontSize: 20.sp,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.sp),
            child: CustomButtons.simpleButton(
              onPressed: isSaving ? null : _savePlaceToFirestore,
              text: isSaving ? "Saving..." : "Save Place",
              width: 120.w,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left side - Form
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[50],
              padding: EdgeInsets.all(24.sp),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWeight700(
                        text: "Place Information",
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.sp),
                      CommonText.textBoldWeight400(
                        text: "Add details for your saved place",
                        fontSize: 16.sp,
                        color: Colors.grey[600]!,
                      ),
                      SizedBox(height: 32.sp),

                      // Label field
                      CommonText.textBoldWeight600(
                        text: "Place Label",
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.sp),
                      TextFormField(
                        controller: _labelController,
                        decoration: InputDecoration(
                          hintText: "e.g., Home, Office, Gym",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 12.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a label for this place';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.sp),

                      // Sub-label field
                      CommonText.textBoldWeight600(
                        text: "Place Description",
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.sp),
                      TextFormField(
                        controller: _subLabelController,
                        decoration: InputDecoration(
                          hintText: "e.g., Downtown Business District",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 12.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a description for this place';
                          }
                          return null;
                        },
                        maxLines: 2,
                      ),
                      SizedBox(height: 24.sp),

                      // Current location info
                      if (selectedLocation != null) ...[
                        Container(
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8.sp),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.textBoldWeight600(
                                text: "Selected Location",
                                fontSize: 14.sp,
                                color: Colors.blue[700]!,
                              ),
                              SizedBox(height: 8.sp),
                              CommonText.textBoldWeight400(
                                text:
                                    "Latitude: ${selectedLocation!.latitude.toStringAsFixed(6)}",
                                fontSize: 12.sp,
                                color: Colors.grey[700]!,
                              ),
                              CommonText.textBoldWeight400(
                                text:
                                    "Longitude: ${selectedLocation!.longitude.toStringAsFixed(6)}",
                                fontSize: 12.sp,
                                color: Colors.grey[700]!,
                              ),
                              if (currentLocationName != null) ...[
                                SizedBox(height: 8.sp),
                                CommonText.textBoldWeight400(
                                  text: currentLocationName!,
                                  fontSize: 12.sp,
                                  color: Colors.grey[600]!,
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 24.sp),
                      ],

                      // Instructions
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.amber[700],
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.sp),
                                CommonText.textBoldWeight600(
                                  text: "Instructions",
                                  fontSize: 14.sp,
                                  color: Colors.amber[700]!,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.sp),
                            CommonText.textBoldWeight400(
                              text:
                                  "• Move the map to select your desired location\n"
                                  "• The pin will show your selected coordinates\n"
                                  "• Fill in a meaningful label and description\n"
                                  "• Click 'Save Place' to add it to your saved places",
                              fontSize: 12.sp,
                              color: Colors.amber[700]!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                      if (selectedLocation != cameraPosition.target) {
                        setState(() {
                          selectedLocation = cameraPosition.target;
                        });
                      }
                    },
                    onCameraIdle: () async {
                      if (selectedLocation != null && !isFirstLoading) {
                        await _fetchAddressFromLatLng(
                          latitude: selectedLocation!.latitude,
                          longitude: selectedLocation!.longitude,
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
                            if (currentLocationName != null)
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
                  if (isFirstLoading || isFetchingAddress)
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
