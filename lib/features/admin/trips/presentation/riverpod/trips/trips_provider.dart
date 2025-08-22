import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:js' as js;

import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/riverpod/rents_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/active_nearby_drivers_model.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/direction_details_info_model.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/predicted_places_model.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_state.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/directions_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/driver_info_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/notification_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/wallet_trip_payment_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:http/http.dart' as http;

class TripsNotifier extends StateNotifier<TripsState> {
  final Ref ref;

  TripsNotifier(this.ref) : super(const TripsState());

  StreamSubscription<dynamic>? _geoFireSubscription;
  List<ActiveNearByDriversModel> nearbyActiveDrivers = [];
  bool activeNearbyDriverKeysLoaded = false;

  // ====================== ORIGINAL TRIP MANAGEMENT ======================

  Future<void> getAllTrips() async {
    state = state.copyWith(failure: null, isGettingAllTripsLoading: true);
    final result = await ref.read(tripsRepositoryProvider).getAllTrips();

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingAllTripsLoading: false, trips: []);
      },
      (trips) async {
        state = state.copyWith(trips: trips, isGettingAllTripsLoading: false);
      },
    );
  }

  Future<void> getTripById({required String tripId}) async {
    state = state.copyWith(failure: null, isGettingTripLoading: true);
    final result =
        await ref.read(tripsRepositoryProvider).getTripById(tripId: tripId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingTripLoading: false, trips: []);
      },
      (trip) async {
        state = state.copyWith(trip: trip, isGettingTripLoading: false);
      },
    );
  }

  Future<void> endTrip({required String tripId}) async {
    state = state.copyWith(failure: null, isGettingTripLoading: true);
    final result =
        await ref.read(tripsRepositoryProvider).endTrip(tripId: tripId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingTripLoading: false, trips: []);
      },
      (trip) async {
        bool resultPay = false;
        List<TripModel> trips = state.trips!;

        final index = trips.indexWhere((element) => element.id == trip.id);
        if (index != -1) {
          trips[index] = trip;
        }
        DailyEarningModel dailyEarningModel = DailyEarningModel(
          amount: trip.fare,
          date: DateTime.now().toString(),
          method: trip.paymentMethod,
        );
        List<DailyEarningModel> dailyEarnings = [
          ...trip.driver.driverInfo!.dailyEarnings,
          dailyEarningModel,
        ];
        if (trip.paymentMethod == "wallet") {
          WalletTripPaymentModel walletTripPaymentModel =
              WalletTripPaymentModel(
            amount: trip.fare,
            userId: trip.user.id,
            date: DateTime.now().toString(),
            tripId: trip.id,
            userFullName: "${trip.user.firstName} ${trip.user.lastName}",
            isPaidByAdmin: false,
          );
          List<WalletTripPaymentModel> wallet = [
            ...trip.driver.driverInfo!.walletTripPayments,
            walletTripPaymentModel,
          ];
          resultPay = await updateTwoUsers(
            driver: trip.driver.copyWith(
              driverInfo: trip.driver.driverInfo!.copyWith(
                walletTripPayments: wallet,
                dailyEarnings: dailyEarnings,
              ),
            ),
            user: trip.user.copyWith(
              walletBalance: trip.user.walletBalance - trip.fare,
            ),
            amount: trip.fare,
          );
        } else {
          resultPay = await updateUser(
            trip.driver.copyWith(
              driverInfo: trip.driver.driverInfo!.copyWith(
                dailyEarnings: dailyEarnings,
              ),
            ),
          );
        }
        await ref.read(rentsNotifierProvider.notifier).sendNotification(
              deviceRegistrationToken: trip.user.deviceToken,
              title: "Trip Ended",
              body:
                  'The trip to go from ${trip.userPickupLocation.locationName} to '
                  '${trip.destinationAddressNames.join(', ')} has end and the total price is ${trip.fare} MRU',
            );
        await ref.read(rentsNotifierProvider.notifier).sendNotification(
              deviceRegistrationToken: trip.driver.deviceToken,
              title: "Trip Ended",
              body:
                  'The trip to go from ${trip.userPickupLocation.locationName} to '
                  '${trip.destinationAddressNames.join(', ')} has end and the total price is ${trip.fare} MRU',
            );

        state = state.copyWith(trips: trips, isGettingTripLoading: false);
      },
    );
  }

  Future<bool> updateTwoUsers({
    required UserModel user,
    required UserModel driver,
    required double amount,
  }) async {
    state = state.copyWith(failure: null);
    final result = await ref
        .read(tripsRepositoryProvider)
        .updateTwoUsers(user: user, driver: driver, amount: amount);

    return result.fold(
      (failure) {
        state = state.copyWith(failure: failure);
        return false;
      },
      (user) async {
        return true;
      },
    );
  }

  Future<bool> updateUser(UserModel user) async {
    state = state.copyWith(failure: null);
    final result = await ref.read(tripsRepositoryProvider).updateUser(user);

    return result.fold(
      (failure) {
        state = state.copyWith(failure: failure);
        return false;
      },
      (user) async {
        return true;
      },
    );
  }

  // ====================== ADD TRIP FUNCTIONALITY ======================

  Future<TripModel?> createTrip({
    required UserModel user,
    required UserModel driver,
    required double fare,
    required String paymentMethod,
    required bool isStopOver,
  }) async {
    if (state.userPickupLocation == null ||
        state.userDropOffLocations.isEmpty) {
      state = state.copyWith(failure: null);
      return null;
    }

    state = state.copyWith(isCreatingTrip: true, failure: null);

    try {
      List<String> destinationNames = state.userDropOffLocations
          .map((location) => location.locationName ?? 'Unknown Location')
          .toList();

      final tripModel = TripModel(
        userPickupLocation: state.userPickupLocation!,
        userDropOffLocations: state.userDropOffLocations,
        time: DateTime.now().toString(),
        paymentMethod: paymentMethod,
        originAddressName:
            state.userPickupLocation!.locationName ?? 'Unknown Location',
        destinationAddressNames: destinationNames,
        driver: driver,
        user: user,
        isStopOver: isStopOver,
        fare: fare,
        status: 'pending',
        distance: state.totalDistanceMeters,
        duration: state.totalDurationSeconds,
      );
      final result =
          await ref.read(tripsRepositoryProvider).createRideRequest(tripModel);

      return result.fold(
        (failure) {
          state = state.copyWith(failure: failure);
          return null;
        },
        (trip) async {
          await sendTripNotificationToDriver(
            driverDeviceToken: trip.driver.deviceToken,
            trip: trip,
          );
          NotificationModel notificationModel = NotificationModel(
            body:
                "You recieved a trip request from Fasti Agent to go from ${trip.userPickupLocation.locationName} to ${trip.destinationAddressNames.join(', ')}",
            title:
                "Trip Request from ${trip.user.firstName} ${trip.user.lastName}",
            date: DateTime.now(),
            type: "tripRequest",
          );
          List<NotificationModel> notifications = [
            ...trip.driver.notifications,
            notificationModel,
          ];
          await ref
              .read(tripsRepositoryProvider)
              .updateUser(trip.driver.copyWith(notifications: notifications));
          // Add to local trips list
          final List<TripModel> updatedTrips = [
            ...state.trips ?? [],
            tripModel
          ];

          state = state.copyWith(
            isCreatingTrip: false,
            trips: updatedTrips,
            // Reset add trip form fields
          );

          return trip;
        },
      );
    } catch (e) {
      state = state.copyWith(isCreatingTrip: false, failure: null);
      return null;
    }
  }

  void resetTripData() {
    state = state.copyWith(
      userPickupLocation: null,
      userDropOffLocations: [],
      totalDistanceMeters: 0,
      totalDurationSeconds: 0,
    );
  }

  // ====================== LOCATION MANAGEMENT ======================

  void updatePickupLocationAddress(DirectionsModel userPickupAddress) {
    state = state.copyWith(userPickupLocation: userPickupAddress);
  }

  void updateDropOffLocationAddress(DirectionsModel dropOffAddress, int index) {
    final currentList = List<DirectionsModel>.from(state.userDropOffLocations);
    if (index >= 0 && index < currentList.length) {
      currentList[index] = dropOffAddress;
      state = state.copyWith(userDropOffLocations: currentList);
    }
  }

  void addDropOffLocation(DirectionsModel newDropOff) {
    final currentList = List<DirectionsModel>.from(state.userDropOffLocations);
    currentList.insert(0, newDropOff);
    state = state.copyWith(userDropOffLocations: currentList);
  }

  void initDropOffLocation() {
    if (state.userDropOffLocations.isEmpty) {
      state = state.copyWith(userDropOffLocations: [const DirectionsModel()]);
    }
  }

  void deleteDropOffLocationAt(int index) {
    final currentList = List<DirectionsModel>.from(state.userDropOffLocations);
    if (index >= 0 && index < currentList.length) {
      currentList.removeAt(index);
      state = state.copyWith(userDropOffLocations: currentList);
    }
  }

  void swapDropOffAndPickupLocation() {
    final userPickupAddress = state.userPickupLocation;
    final dropOffList = state.userDropOffLocations;

    if (dropOffList.isNotEmpty && userPickupAddress != null) {
      final newPickup = dropOffList[0];
      final newDropOffList = [userPickupAddress];

      state = state.copyWith(
        userPickupLocation: newPickup,
        userDropOffLocations: newDropOffList,
      );
    }
  }

  void resetLocationAddresses() {
    state = state.copyWith(
      userPickupLocation: null,
      userDropOffLocations: [],
      totalDistanceMeters: 0,
      totalDurationSeconds: 0,
    );
  }

  // ====================== ADDRESS & GEOCODING ======================

  Future<String> fetchAddressFromLatLng({
    required double latitude,
    required double longitude,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isFetchingAddress: true);

      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (mapKey == null) {
        throw Exception('Google Maps API key not found');
      }

      final data = await Geocoder2.getDataFromCoordinates(
        latitude: latitude,
        longitude: longitude,
        googleMapApiKey: mapKey,
      );

      final address = data.address;
      final parts = address.split(',').map((e) => e.trim()).toList();
      final city = data.city?.trim().toLowerCase();
      final country = data.country?.trim().toLowerCase();
      final plusCodeRegex = RegExp(r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}$');
      String? streetName;
      for (final part in parts) {
        final partLower = part.toLowerCase();
        if (part.isNotEmpty &&
            !plusCodeRegex.hasMatch(part) &&
            partLower != city &&
            partLower != country) {
          streetName = part;
          break;
        }
      }

      final cleanedAddress = (streetName == null ||
              streetName.toLowerCase().contains(city ?? '') ||
              streetName.toLowerCase().contains(country ?? ''))
          ? "Unnamed Street, $city"
          : "$streetName, $city";

      state = state.copyWith(isFetchingAddress: false);
      return cleanedAddress;
    } catch (e) {
      log("Error fetching address: $e");
      state = state.copyWith(isFetchingAddress: false);
      return 'Unknown Location';
    }
  }

  Future<String> fetchAddressFromLatLngWithEstablishments({
    required double latitude,
    required double longitude,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isFetchingAddress: true);

      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (mapKey == null) {
        throw Exception('Google Maps API key not found');
      }

      // Try to find establishments using area-based search
      String? establishmentName =
          await _getEstablishmentAtCoordinates(latitude, longitude, mapKey);

      // If we found an establishment, return it
      if (establishmentName != null && establishmentName.isNotEmpty) {
        state = state.copyWith(isFetchingAddress: false);
        return establishmentName;
      }

      // Fallback to regular geocoding if no establishment found
      final data = await Geocoder2.getDataFromCoordinates(
        latitude: latitude,
        longitude: longitude,
        googleMapApiKey: mapKey,
      );

      final address = data.address;
      final parts = address.split(',').map((e) => e.trim()).toList();
      final city = data.city?.trim().toLowerCase();
      final country = data.country?.trim().toLowerCase();
      final plusCodeRegex = RegExp(r'^[A-Z0-9]{4,}\+[A-Z0-9]{2,}$');
      String? streetName;

      for (final part in parts) {
        final partLower = part.toLowerCase();
        if (part.isNotEmpty &&
            !plusCodeRegex.hasMatch(part) &&
            partLower != city &&
            partLower != country) {
          streetName = part;
          break;
        }
      }

      final cleanedAddress = (streetName == null ||
              streetName.toLowerCase().contains(city ?? '') ||
              streetName.toLowerCase().contains(country ?? ''))
          ? "Unnamed Street, $city"
          : "$streetName, $city";

      state = state.copyWith(isFetchingAddress: false);
      return cleanedAddress;
    } catch (e) {
      log("Error fetching address: $e");
      state = state.copyWith(isFetchingAddress: false);
      return 'Unknown Location';
    }
  }

// New approach: Search for common establishment types near the coordinates
  Future<String?> _getEstablishmentAtCoordinates(
      double latitude, double longitude, String mapKey) async {
    try {
      if (kIsWeb) {
        return await _getEstablishmentWebSearch(latitude, longitude);
      } else {
        return await _getEstablishmentHttpNearby(latitude, longitude, mapKey);
      }
    } catch (e) {
      print("Error in establishment detection: $e");
      return null;
    }
  }

// Web implementation: Use multiple search terms to find establishments
  Future<String?> _getEstablishmentWebSearch(
      double latitude, double longitude) async {
    try {
      final google = js.context['google'];

      if (google == null ||
          google['maps'] == null ||
          google['maps']['places'] == null) {
        print("Places library not loaded");
        return null;
      }

      // Import library
      final importLibrary = js.context['google']['maps']['importLibrary'];
      if (importLibrary != null) {
        final importCompleter = Completer<void>();
        final promise =
            importLibrary.callMethod('call', [js.context, 'places']);

        promise.callMethod('then', [
          js.allowInterop((result) {
            importCompleter.complete();
          })
        ]);

        promise.callMethod('catch', [
          js.allowInterop((error) {
            print("Error importing places library: $error");
            importCompleter.completeError(error);
          })
        ]);

        await importCompleter.future;
      }

      final placesLibrary = js.context['google']['maps']['places'];
      if (placesLibrary == null) {
        print("Places library not available after import");
        return null;
      }

      final AutocompleteSuggestion = placesLibrary['AutocompleteSuggestion'];
      if (AutocompleteSuggestion != null &&
          AutocompleteSuggestion['fetchAutocompleteSuggestions'] != null) {
        // Try multiple search terms that might match establishments in the area
        final searchTerms = [
          'restaurant',
          'store',
          'shop',
          'cafe',
          'business',
          'gym',
          'showroom',
          'center',
          'office',
          'building'
        ];

        for (final searchTerm in searchTerms) {
          final completer = Completer<String?>();

          final request = js.JsObject.jsify({
            'input': searchTerm,
            'locationBias': js.JsObject.jsify({
              'center': js.JsObject.jsify({
                'lat': latitude,
                'lng': longitude,
              }),
              'radius': 100, // Small radius to find nearby establishments
            }),
            'includedPrimaryTypes': ['establishment'],
          });

          final promise = AutocompleteSuggestion.callMethod(
              'fetchAutocompleteSuggestions', [request]);

          promise.callMethod('then', [
            js.allowInterop((result) {
              try {
                final suggestions =
                    result['suggestions'] as List<dynamic>? ?? [];

                if (suggestions.isNotEmpty) {
                  // Find the closest establishment to our coordinates
                  _findClosestEstablishment(
                      suggestions, latitude, longitude, completer, google);
                } else {
                  completer.complete(null);
                }
              } catch (e) {
                print("Error processing suggestions for $searchTerm: $e");
                completer.complete(null);
              }
            })
          ]);

          promise.callMethod('catch', [
            js.allowInterop((error) {
              print("Error searching for $searchTerm: $error");
              completer.complete(null);
            })
          ]);

          final result = await completer.future.timeout(
            Duration(seconds: 3),
            onTimeout: () => null,
          );

          if (result != null) {
            print(
                "Found establishment with search term '$searchTerm': $result");
            return result;
          }
        }
      }

      return null;
    } catch (e) {
      print("Error in web establishment search: $e");
      return null;
    }
  }

// Helper method to find the closest establishment to the clicked coordinates
  Future<void> _findClosestEstablishment(
      List<dynamic> suggestions,
      double targetLat,
      double targetLng,
      Completer<String?> completer,
      js.JsObject google) async {
    try {
      String? closestEstablishment;
      double closestDistance = double.infinity;

      final List<Future<void>> futures = [];

      for (var suggestion in suggestions.take(5)) {
        // Check first 5 suggestions
        final future =
            _checkSuggestionDistance(suggestion, targetLat, targetLng, google)
                .then((result) {
          if (result != null) {
            final distance = result['distance'] as double;
            final name = result['name'] as String;

            if (distance < closestDistance && distance < 200) {
              // Within 200 meters
              closestDistance = distance;
              closestEstablishment = name;
            }
          }
        }).catchError((e) {
          print("Error checking suggestion: $e");
        });

        futures.add(future);
      }

      await Future.wait(futures);

      completer.complete(closestEstablishment);
    } catch (e) {
      print("Error finding closest establishment: $e");
      completer.complete(null);
    }
  }

// Check if a suggestion is close to our target coordinates
  Future<Map<String, dynamic>?> _checkSuggestionDistance(dynamic suggestion,
      double targetLat, double targetLng, js.JsObject google) async {
    try {
      final placePrediction = suggestion['placePrediction'];
      if (placePrediction == null) return null;

      final placeId = placePrediction['placeId'];
      if (placeId == null) return null;

      final completer = Completer<Map<String, dynamic>?>();

      // Use the same Place.fetchFields pattern as your working code
      final Place = google['maps']['places']['Place'];
      final place = js.JsObject(Place, [
        js.JsObject.jsify({'id': placeId})
      ]);

      final fieldsToFetch = [
        'id',
        'displayName',
        'formattedAddress',
        'location'
      ];
      final fetchDetailsPromise = place.callMethod('fetchFields', [
        js.JsObject.jsify({'fields': fieldsToFetch})
      ]);

      fetchDetailsPromise.callMethod('then', [
        js.allowInterop((placeResult) {
          try {
            if (placeResult != null && placeResult['place'] != null) {
              final placeData = placeResult['place'];
              final location = placeData['location'];

              if (location != null) {
                double? lat, lng;

                // Use the same coordinate extraction logic as your searchAddressAutoComplete
                try {
                  if (location['lat'] != null) {
                    lat = double.tryParse(location['lat'].toString());
                  }
                  if (location['lng'] != null) {
                    lng = double.tryParse(location['lng'].toString());
                  }

                  if (lat == null) {
                    try {
                      final latResult = location.callMethod('lat');
                      if (latResult != null) {
                        lat = double.tryParse(latResult.toString());
                      }
                    } catch (e) {}
                  }

                  if (lng == null) {
                    try {
                      final lngResult = location.callMethod('lng');
                      if (lngResult != null) {
                        lng = double.tryParse(lngResult.toString());
                      }
                    } catch (e) {}
                  }
                } catch (e) {
                  print("Error extracting coordinates: $e");
                }

                if (lat != null && lng != null) {
                  final distance =
                      calculateDistance(targetLat, targetLng, lat, lng);

                  // Extract name
                  String displayName = '';
                  try {
                    final displayNameObj = placeData['displayName'];
                    if (displayNameObj != null) {
                      if (displayNameObj is String) {
                        displayName = displayNameObj;
                      } else if (displayNameObj['text'] != null) {
                        displayName = displayNameObj['text'].toString();
                      } else {
                        displayName = displayNameObj.toString();
                      }
                    }
                  } catch (e) {
                    print("Error extracting displayName: $e");
                  }

                  if (displayName.isNotEmpty) {
                    completer.complete({
                      'distance': distance,
                      'name': displayName,
                    });
                  } else {
                    completer.complete(null);
                  }
                } else {
                  completer.complete(null);
                }
              } else {
                completer.complete(null);
              }
            } else {
              completer.complete(null);
            }
          } catch (e) {
            print("Error processing place result: $e");
            completer.complete(null);
          }
        })
      ]);

      fetchDetailsPromise.callMethod('catch', [
        js.allowInterop((error) {
          print("Error fetching place details: $error");
          completer.complete(null);
        })
      ]);

      return await completer.future.timeout(
        Duration(seconds: 2),
        onTimeout: () => null,
      );
    } catch (e) {
      print("Error in distance check: $e");
      return null;
    }
  }

// Mobile HTTP implementation (keep the same as before)
  Future<String?> _getEstablishmentHttpNearby(
      double latitude, double longitude, String mapKey) async {
    try {
      final establishmentUrl = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
          "?location=$latitude,$longitude"
          "&radius=50"
          "&type=establishment"
          "&key=$mapKey");

      print("Searching for establishments at: $latitude, $longitude");

      final establishmentResponse =
          await http.get(establishmentUrl).timeout(Duration(seconds: 5));

      if (establishmentResponse.statusCode == 200) {
        final establishmentData = jsonDecode(establishmentResponse.body);
        final establishmentResults =
            establishmentData['results'] as List<dynamic>;

        print("Found ${establishmentResults.length} establishments");

        if (establishmentResults.isNotEmpty) {
          final place = establishmentResults.first;
          final name = place['name'];
          final vicinity = place['vicinity'];

          if (name != null) {
            String establishmentName;
            if (vicinity != null && vicinity.toString().isNotEmpty) {
              establishmentName = '$name, $vicinity';
            } else {
              establishmentName = name.toString();
            }

            print("Selected establishment: $establishmentName");
            return establishmentName;
          }
        }
      }

      return null;
    } catch (e) {
      print("Error in HTTP establishment detection: $e");
      return null;
    }
  }

  Future<String> searchAddressForGeographicCoordinates({
    required double latitude,
    required double longitude,
    required bool isCurrentUserLocation,
  }) async {
    state = state.copyWith(isFetchingAddress: true);

    try {
      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (mapKey == null) {
        throw Exception('Google Maps API key not found');
      }

      final apiUrl = "https://maps.googleapis.com/maps/api/geocode/json"
          "?latlng=$latitude,$longitude&key=$mapKey";

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final humanReadableAddress = data["results"][0]["formatted_address"];

        final userAddress = DirectionsModel(
          locationName: humanReadableAddress,
          locationLatitude: latitude,
          locationLongitude: longitude,
        );

        if (isCurrentUserLocation) {
          updatePickupLocationAddress(userAddress);
        }

        state = state.copyWith(isFetchingAddress: false);
        return humanReadableAddress;
      } else {
        throw Exception('Failed to fetch address');
      }
    } catch (e) {
      log("Error searching address: $e");
      state = state.copyWith(isFetchingAddress: false);
      return 'Unknown Location';
    }
  }

  // ====================== PLACE SEARCH & AUTOCOMPLETE ======================

  Future<List<PredictedPlacesModel>> searchAddressAutoComplete({
    required String inputText,
    required double userLat,
    required double userLng,
  }) async {
    if (inputText.length <= 2) return [];

    state = state.copyWith(isSearchLoading: true);

    try {
      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (mapKey == null) throw Exception('Google Maps API key not found');

      if (kIsWeb) {
        final completer = Completer<List<PredictedPlacesModel>>();
        final google = js.context['google'];
        if (google == null ||
            google['maps'] == null ||
            google['maps']['places'] == null) {
          print("Places library not loaded");
          state = state.copyWith(isSearchLoading: false);
          return [];
        }

        final importLibrary = js.context['google']['maps']['importLibrary'];
        if (importLibrary != null) {
          // Properly await the importLibrary promise
          final importCompleter = Completer<void>();
          final promise =
              importLibrary.callMethod('call', [js.context, 'places']);

          promise.callMethod('then', [
            js.allowInterop((result) {
              importCompleter.complete();
            })
          ]);

          promise.callMethod('catch', [
            js.allowInterop((error) {
              print("Error importing places library: $error");
              importCompleter.completeError(error);
            })
          ]);

          await importCompleter.future;
        }

        // Now use the standard Places API
        final placesLibrary = js.context['google']['maps']['places'];
        if (placesLibrary == null) {
          print("Places library not available after import");
          state = state.copyWith(isSearchLoading: false);
          return [];
        }

        // Use AutocompleteSuggestion from the standard Places API
        final AutocompleteSuggestion = placesLibrary['AutocompleteSuggestion'];
        if (AutocompleteSuggestion != null &&
            AutocompleteSuggestion['fetchAutocompleteSuggestions'] != null) {
          final request = js.JsObject.jsify({
            'input': inputText,
            'locationBias': js.JsObject.jsify({
              'center': js.JsObject.jsify({
                'lat': userLat,
                'lng': userLng,
              }),
              'radius': 20000,
            }),
            'includedPrimaryTypes': ['establishment'],
          });

          final promise = AutocompleteSuggestion.callMethod(
              'fetchAutocompleteSuggestions', [request]);

          promise.callMethod('then', [
            js.allowInterop((result) {
              try {
                final suggestions =
                    result['suggestions'] as List<dynamic>? ?? [];
                final List<Future<PredictedPlacesModel?>> futures = [];

                // Get details for each suggestion using the new Places API approach
                for (var suggestion in suggestions) {
                  final placePrediction = suggestion['placePrediction'];
                  if (placePrediction != null) {
                    final placeId = placePrediction['placeId'];
                    if (placeId != null) {
                      final detailCompleter =
                          Completer<PredictedPlacesModel?>();

                      try {
                        // Create a Place object with the placeId
                        final Place = google['maps']['places']['Place'];
                        final place = js.JsObject(Place, [
                          js.JsObject.jsify({
                            'id': placeId,
                          })
                        ]);

                        // Define the fields we want to fetch
                        final fieldsToFetch = [
                          'id',
                          'displayName',
                          'formattedAddress',
                          'location',
                        ];

                        // Fetch place details
                        final fetchDetailsPromise =
                            place.callMethod('fetchFields', [
                          js.JsObject.jsify({'fields': fieldsToFetch})
                        ]);

                        fetchDetailsPromise.callMethod('then', [
                          js.allowInterop((placeResult) {
                            try {
                              if (placeResult != null &&
                                  placeResult['place'] != null) {
                                final placeData = placeResult['place'];
                                final location = placeData['location'];

                                if (location != null) {
                                  double? lat;
                                  double? lng;

                                  // Try multiple ways to extract coordinates
                                  try {
                                    // Method 1: Direct property access
                                    if (location['lat'] != null) {
                                      lat = double.tryParse(
                                          location['lat'].toString());
                                    }
                                    if (location['lng'] != null) {
                                      lng = double.tryParse(
                                          location['lng'].toString());
                                    }

                                    // Method 2: Call lat() and lng() methods if direct access fails
                                    if (lat == null) {
                                      try {
                                        final latResult =
                                            location.callMethod('lat');
                                        if (latResult != null) {
                                          lat = double.tryParse(
                                              latResult.toString());
                                        }
                                      } catch (e) {
                                        // lat() method not available, continue
                                      }
                                    }

                                    if (lng == null) {
                                      try {
                                        final lngResult =
                                            location.callMethod('lng');
                                        if (lngResult != null) {
                                          lng = double.tryParse(
                                              lngResult.toString());
                                        }
                                      } catch (e) {
                                        // lng() method not available, continue
                                      }
                                    }

                                    // Method 3: Parse from string representation
                                    if (lat == null || lng == null) {
                                      final locationString =
                                          location.toString();
                                      print(
                                          "Parsing location string: '$locationString'");

                                      if (locationString.contains('(') &&
                                          locationString.contains(')')) {
                                        // Remove parentheses and split by comma
                                        final coordsString = locationString
                                            .replaceAll('(', '')
                                            .replaceAll(')', '')
                                            .trim();

                                        final coords = coordsString.split(',');
                                        print("Split coordinates: $coords");

                                        if (coords.length >= 2) {
                                          lat =
                                              double.tryParse(coords[0].trim());
                                          lng =
                                              double.tryParse(coords[1].trim());
                                          print("Parsed lat: $lat, lng: $lng");
                                        }
                                      }
                                    }

                                    // Method 4: Try accessing alternative property names
                                    if (lat == null &&
                                        location['latitude'] != null) {
                                      lat = double.tryParse(
                                          location['latitude'].toString());
                                    }
                                    if (lng == null &&
                                        location['longitude'] != null) {
                                      lng = double.tryParse(
                                          location['longitude'].toString());
                                    }
                                  } catch (e) {
                                    print("Error extracting coordinates: $e");
                                    print("Location object: $location");
                                    print(
                                        "Location type: ${location.runtimeType}");
                                  }

                                  if (lat != null && lng != null) {
                                    print(
                                        "Successfully extracted coordinates: lat=$lat, lng=$lng");
                                    final distance = calculateDistance(
                                        userLat, userLng, lat, lng);

                                    // Extract display name safely
                                    String displayName = '';
                                    try {
                                      final displayNameObj =
                                          placeData['displayName'];
                                      if (displayNameObj != null) {
                                        if (displayNameObj is String) {
                                          displayName = displayNameObj;
                                        } else if (displayNameObj['text'] !=
                                            null) {
                                          displayName =
                                              displayNameObj['text'].toString();
                                        } else {
                                          displayName =
                                              displayNameObj.toString();
                                        }
                                      }
                                    } catch (e) {
                                      print("Error extracting displayName: $e");
                                      print(
                                          "DisplayName object: ${placeData['displayName']}");
                                      displayName = '';
                                    }

                                    // Extract address safely
                                    String address = '';
                                    try {
                                      final addressObj =
                                          placeData['formattedAddress'];
                                      if (addressObj != null) {
                                        address = addressObj.toString();
                                      }
                                    } catch (e) {
                                      print("Error extracting address: $e");
                                      address = '';
                                    }

                                    // Fallback: if displayName is still empty, try using address or placeId
                                    if (displayName.isEmpty) {
                                      if (address.isNotEmpty) {
                                        displayName =
                                            'Place'; // Generic name when no display name available
                                      } else {
                                        displayName = 'Unknown Place';
                                      }
                                    }

                                    print(
                                        "Extracted - DisplayName: '$displayName', Address: '$address'");

                                    detailCompleter
                                        .complete(PredictedPlacesModel(
                                      placeId: placeId,
                                      mainText: displayName.isNotEmpty
                                          ? '$displayName ${address.isNotEmpty ? '- $address' : ''}'
                                          : address.isNotEmpty
                                              ? address
                                              : 'Unknown Place',
                                      latitude: lat,
                                      longitude: lng,
                                      secondaryText: address,
                                      distanceInMeters: distance,
                                    ));
                                  } else {
                                    print(
                                        "Failed to extract coordinates. lat=$lat, lng=$lng");
                                    print("Location object structure:");
                                    print("Location: $location");

                                    // Try to inspect all properties of the location object
                                    if (location is js.JsObject) {
                                      try {
                                        final properties = js.context
                                            .callMethod(
                                                'Object.keys', [location]);
                                        print(
                                            "Available properties: $properties");
                                      } catch (e) {
                                        print(
                                            "Could not inspect properties: $e");
                                      }
                                    }

                                    detailCompleter.complete(null);
                                  }
                                } else {
                                  print("Location not available in place data");
                                  detailCompleter.complete(null);
                                }
                              } else {
                                print("Place result or place data is null");
                                detailCompleter.complete(null);
                              }
                            } catch (e) {
                              print("Error processing place details: $e");
                              detailCompleter.complete(null);
                            }
                          })
                        ]);

                        fetchDetailsPromise.callMethod('catch', [
                          js.allowInterop((error) {
                            print(
                                "Error fetching place details for $placeId: $error");
                            detailCompleter.complete(null);
                          })
                        ]);

                        futures.add(detailCompleter.future);
                      } catch (e) {
                        print("Error creating Place object for $placeId: $e");
                        // Complete with null for this place
                        detailCompleter.complete(null);
                        futures.add(detailCompleter.future);
                      }
                    }
                  }
                }

                // Wait for all detail requests to complete
                Future.wait(futures).then((results) {
                  final places = results
                      .whereType<PredictedPlacesModel>()
                      .toList()
                    ..sort((a, b) => (a.distanceInMeters ?? 0)
                        .compareTo(b.distanceInMeters ?? 0));

                  state = state.copyWith(
                      isSearchLoading: false, searchResults: places);
                  completer.complete(places);
                }).catchError((error) {
                  print("Error waiting for place details: $error");
                  state = state.copyWith(isSearchLoading: false);
                  completer.complete([]);
                });
              } catch (e) {
                print("Error processing autocomplete suggestions: $e");
                state = state.copyWith(isSearchLoading: false);
                completer.complete([]);
              }
            })
          ]);

          promise.callMethod('catch', [
            js.allowInterop((error) {
              print("Error in fetchAutocompleteSuggestions: $error");
              state = state.copyWith(isSearchLoading: false);
              completer.complete([]);
            })
          ]);
        } else {
          // Fallback to HTTP API if AutocompleteSuggestion is not available
          print("AutocompleteSuggestion not available, using HTTP fallback");
          final httpResults =
              await _fallbackToHttpApi(inputText, userLat, userLng, mapKey);
          state = state.copyWith(
              isSearchLoading: false, searchResults: httpResults);
          completer.complete(httpResults);
        }

        return completer.future;
      } else {
        // Mobile/native implementation remains the same
        return await _mobileAutocomplete(inputText, userLat, userLng, mapKey);
      }
    } catch (e) {
      print("Error searching places: $e");
      state = state.copyWith(isSearchLoading: false);
      return [];
    }
  }

  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$mapKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
      throw Exception('Geocoding failed');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

// Helper method for HTTP fallback
  Future<List<PredictedPlacesModel>> _fallbackToHttpApi(
      String inputText, double userLat, double userLng, String mapKey) async {
    try {
      final apiUrl = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json"
          "?input=$inputText"
          "&location=$userLat,$userLng"
          "&radius=20000"
          "&types=establishment"
          "&key=$mapKey");

      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final predictions = data['predictions'] as List<dynamic>;

        final List<Future<PredictedPlacesModel?>> futures =
            predictions.map((prediction) async {
          final placeId = prediction['place_id'];
          if (placeId != null) {
            return await _getPlaceDetailsHttp(
                placeId, userLat, userLng, mapKey);
          }
          return null;
        }).toList();

        final results = await Future.wait(futures);
        final places = results.whereType<PredictedPlacesModel>().toList()
          ..sort((a, b) =>
              (a.distanceInMeters ?? 0).compareTo(b.distanceInMeters ?? 0));

        return places;
      } else {
        throw Exception(
            'Autocomplete failed with status ${response.statusCode}');
      }
    } catch (e) {
      print("Error in HTTP fallback: $e");
      return [];
    }
  }

// Helper method for mobile autocomplete
  Future<List<PredictedPlacesModel>> _mobileAutocomplete(
      String inputText, double userLat, double userLng, String mapKey) async {
    final apiUrl =
        Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json"
            "?input=$inputText"
            "&location=$userLat,$userLng"
            "&radius=20000"
            "&types=establishment"
            "&key=$mapKey");

    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final predictions = data['predictions'] as List<dynamic>;

      final List<Future<PredictedPlacesModel?>> futures =
          predictions.map((prediction) async {
        final placeId = prediction['place_id'];
        if (placeId != null) {
          return await _getPlaceDetailsHttp(placeId, userLat, userLng, mapKey);
        }
        return null;
      }).toList();

      final results = await Future.wait(futures);
      final places = results.whereType<PredictedPlacesModel>().toList()
        ..sort((a, b) =>
            (a.distanceInMeters ?? 0).compareTo(b.distanceInMeters ?? 0));

      state = state.copyWith(isSearchLoading: false, searchResults: places);
      return places;
    } else {
      throw Exception('Autocomplete failed with status ${response.statusCode}');
    }
  }

// Helper method to get place details via HTTP
  Future<PredictedPlacesModel?> _getPlaceDetailsHttp(
      String placeId, double userLat, double userLng, String mapKey) async {
    try {
      final detailUrl =
          Uri.parse("https://maps.googleapis.com/maps/api/place/details/json"
              "?place_id=$placeId"
              "&fields=place_id,name,formatted_address,geometry"
              "&key=$mapKey");

      final detailResponse = await http.get(detailUrl);
      if (detailResponse.statusCode == 200) {
        final detailData = jsonDecode(detailResponse.body);
        final result = detailData['result'];
        if (result != null && result['geometry'] != null) {
          final location = result['geometry']['location'];
          final lat = location['lat']?.toDouble();
          final lng = location['lng']?.toDouble();

          if (lat != null && lng != null) {
            final distance = calculateDistance(userLat, userLng, lat, lng);
            final name = result['name'] ?? '';
            final address = result['formatted_address'] ?? '';

            return PredictedPlacesModel(
              placeId: placeId,
              mainText: '$name ${address.isNotEmpty ? address : ''}',
              latitude: lat,
              longitude: lng,
              secondaryText: address,
              distanceInMeters: distance,
            );
          }
        }
      }
    } catch (e) {
      print("Error getting place details for $placeId: $e");
    }
    return null;
  }

  Future<List<PredictedPlacesModel>> getNearbyPlaces({
    required double userLat,
    required double userLng,
    required String type,
  }) async {
    state = state.copyWith(isSearchLoading: true);

    try {
      final mapKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (mapKey == null) {
        throw Exception('Google Maps API key not found');
      }

      final url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
          "?location=$userLat,$userLng"
          "&radius=5000"
          "&type=$type"
          "&key=$mapKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List<dynamic>;
        List<PredictedPlacesModel> places = [];

        for (var json in results) {
          final place = PredictedPlacesModel(
            placeId: json['place_id'],
            mainText: '${json['name']} ${json['vicinity']}',
            latitude: json['geometry']['location']['lat']?.toDouble(),
            longitude: json['geometry']['location']['lng']?.toDouble(),
            secondaryText: json['vicinity'],
          );

          if (place.latitude != null && place.longitude != null) {
            final distance = calculateDistance(
                userLat, userLng, place.latitude!, place.longitude!);

            final placeWithDistance =
                place.copyWith(distanceInMeters: distance);
            places.add(placeWithDistance);
          }
        }

        places.sort((a, b) =>
            (a.distanceInMeters ?? 0).compareTo(b.distanceInMeters ?? 0));

        state = state.copyWith(isSearchLoading: false, searchResults: places);
        return places;
      } else {
        throw Exception('Failed to fetch nearby places');
      }
    } catch (e) {
      log("Error fetching nearby places: $e");
      state = state.copyWith(isSearchLoading: false);
      return [];
    }
  }

  // ====================== DIRECTIONS & ROUTING ======================

  Future<DirectionDetailInfoModel?> obtainOriginToDestinationDirectionDetails(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) async {
    try {
      // Use Google Maps JavaScript API instead of HTTP requests
      final completer = Completer<DirectionDetailInfoModel?>();

      // Create the directions service
      final directionsService =
          js.JsObject(js.context['google']['maps']['DirectionsService']);

      // Create request object with proper coordinate handling
      final request = js.JsObject.jsify({
        'origin': {
          'lat': originLat,
          'lng': originLng,
        },
        'destination': {
          'lat': destinationLat,
          'lng': destinationLng,
        },
        'travelMode': js.context['google']['maps']['TravelMode']['DRIVING'],
      });

      // Make the directions request
      directionsService.callMethod('route', [
        request,
        js.allowInterop((result, status) {
          try {
            final statusString = status.toString();
            print("Directions API status: $statusString");

            if (statusString == 'OK' && result != null) {
              final routes = result['routes'];
              if (routes != null && routes.length > 0) {
                final route = routes[0];
                final legs = route['legs'];
                if (legs != null && legs.length > 0) {
                  final leg = legs[0];
                  final distance = leg['distance'];
                  final duration = leg['duration'];
                  final overviewPolyline = route['overview_polyline'];

                  // Safely extract values with proper type conversion
                  String distanceText = '0 km';
                  int distanceValue = 0;
                  String durationText = '0 min';
                  int durationValue = 0;
                  String? polylinePoints;

                  if (distance != null) {
                    distanceText = distance['text']?.toString() ?? '0 km';
                    final distValue = distance['value'];
                    if (distValue != null) {
                      if (distValue is int) {
                        distanceValue = distValue;
                      } else if (distValue is double) {
                        distanceValue = distValue.round();
                      } else if (distValue is String) {
                        distanceValue = int.tryParse(distValue) ?? 0;
                      } else {
                        // Handle JavaScript number conversion
                        distanceValue = (distValue as num).round();
                      }
                    }
                  }

                  if (duration != null) {
                    durationText = duration['text']?.toString() ?? '0 min';
                    final durValue = duration['value'];
                    if (durValue != null) {
                      if (durValue is int) {
                        durationValue = durValue;
                      } else if (durValue is double) {
                        durationValue = durValue.round();
                      } else if (durValue is String) {
                        durationValue = int.tryParse(durValue) ?? 0;
                      } else {
                        // Handle JavaScript number conversion
                        durationValue = (durValue as num).round();
                      }
                    }
                  }

                  if (overviewPolyline != null) {
                    // overviewPolyline itself contains the encoded polyline string
                    polylinePoints = overviewPolyline.toString();
                  }

                  print(
                      "Directions result - Distance: ${distanceValue}m, Duration: ${durationValue}s");

                  final directionDetails = DirectionDetailInfoModel(
                    ePoints: polylinePoints,
                    distanceText: distanceText,
                    distanceValue: distanceValue,
                    durationText: durationText,
                    durationValue: durationValue,
                  );

                  updateTripDirectionDetailsInfo(directionDetails);
                  completer.complete(directionDetails);
                } else {
                  print("No legs found in directions result");
                  completer.complete(null);
                }
              } else {
                print("No routes found in directions result");
                completer.complete(null);
              }
            } else {
              print("Directions request failed with status: $statusString");
              completer.complete(null);
            }
          } catch (e, s) {
            print("Error processing directions result: $e");
            print("Stack trace: $s");
            completer.complete(null);
          }
        })
      ]);

      return await completer.future;
    } catch (e, s) {
      print("Error getting directions: $e");
      print("Stack trace: $s");
      return null;
    }
  }

  void updateTripDirectionDetailsInfo(
      DirectionDetailInfoModel directionDetailInfoModel) {
    state = state.copyWith(tripDirectionDetailsInfo: directionDetailInfoModel);
  }

  void updateTotalDistanceMeters(int distance) {
    state = state.copyWith(
        totalDistanceMeters: state.totalDistanceMeters + distance);
  }

  void updateTotalDurationSeconds(int duration) {
    state = state.copyWith(
        totalDurationSeconds: state.totalDurationSeconds + duration);
  }

  void resetTotalDistanceMeters() {
    state = state.copyWith(totalDistanceMeters: 0);
  }

  void resetTotalDurationSeconds() {
    state = state.copyWith(totalDurationSeconds: 0);
  }

  // ====================== SAVED PLACES ======================

  void loadSavedPlaces() {
    final defaultPlaces = [
      {
        'name': 'Office',
        'address': 'Downtown Business District',
        'icon': 'business',
        'type': 'work',
        'latitude': 33.8869,
        'longitude': 9.5375,
      },
      {
        'name': 'Home',
        'address': 'Residential Area',
        'icon': 'home',
        'type': 'home',
        'latitude': 33.8900,
        'longitude': 9.5400,
      },
      {
        'name': 'Airport',
        'address': 'Tunis-Carthage Airport',
        'icon': 'flight',
        'type': 'airport',
        'latitude': 36.8510,
        'longitude': 10.2272,
      },
    ];

    state = state.copyWith(savedPlaces: defaultPlaces);
  }

  void addSavedPlace(Map<String, dynamic> place) {
    final updatedPlaces = [...state.savedPlaces, place];
    state = state.copyWith(savedPlaces: updatedPlaces);
  }

  void removeSavedPlace(int index) {
    final updatedPlaces = [...state.savedPlaces];
    if (index >= 0 && index < updatedPlaces.length) {
      updatedPlaces.removeAt(index);
      state = state.copyWith(savedPlaces: updatedPlaces);
    }
  }

  // ====================== UTILITY METHODS ======================

  void clearFailure() {
    state = state.copyWith(failure: null);
  }

  void clearSearchResults() {
    state = state.copyWith(searchResults: []);
  }

  void clearAddTripData() {
    state = state.copyWith(
      userPickupLocation: null,
      userDropOffLocations: [const DirectionsModel()],
      totalDistanceMeters: 0,
      totalDurationSeconds: 0,
      searchResults: [],
    );
  }

  // Add these methods to your existing TripsNotifier class

// ====================== DRIVER MANAGEMENT FOR AGENT (WEB-COMPATIBLE) ======================

  Future<List<UserModel>> fetchNearbyDriversForLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 3.0,
  }) async {
    state = state.copyWith(isGettingNearbyDriversLoading: true);

    try {
      // Query Firebase Realtime Database for active drivers
      List<UserModel> nearbyDrivers = await _fetchActiveDriversFromRealtimeDB(
        centerLat: latitude,
        centerLng: longitude,
        radiusKm: radiusKm,
      );

      state = state.copyWith(
        isGettingNearbyDriversLoading: false,
        nearbyDrivers: nearbyDrivers,
      );

      return nearbyDrivers;
    } catch (e, s) {
      print("Error fetching nearby drivers: $e, $s");
      state = state.copyWith(
        isGettingNearbyDriversLoading: false,
        failure: null,
      );
      return <UserModel>[];
    }
  }

  Future<List<UserModel>> _fetchActiveDriversFromRealtimeDB({
    required double centerLat,
    required double centerLng,
    required double radiusKm,
  }) async {
    try {
      // Get reference to the activeDrivers node in Realtime Database
      DatabaseReference activeDriversRef =
          FirebaseDatabase.instance.ref().child("activeDrivers");

      // Get all active drivers data
      DatabaseEvent event = await activeDriversRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (!snapshot.exists || snapshot.value == null) {
        print("No active drivers found in Realtime Database");
        return [];
      }

      Map<dynamic, dynamic> activeDriversData =
          snapshot.value as Map<dynamic, dynamic>;
      List<String> nearbyDriverIds = [];

      // Filter drivers by distance
      activeDriversData.forEach((driverId, locationData) {
        if (locationData != null) {
          // GeoFire stores location in 'g' field as [latitude, longitude]
          var geoData = locationData['l'];
          if (geoData != null && geoData is List && geoData.length >= 2) {
            double driverLat = geoData[0].toDouble();
            double driverLng = geoData[1].toDouble();

            // Calculate distance from pickup location
            double distance =
                calculateDistance(centerLat, centerLng, driverLat, driverLng);
            double distanceKm = distance / 1000;

            if (distanceKm <= radiusKm) {
              nearbyDriverIds.add(driverId.toString());
              print(
                  "Found nearby driver: $driverId at ${distanceKm.toStringAsFixed(1)}km");
            }
          }
        }
      });

      if (nearbyDriverIds.isEmpty) {
        print("No drivers found within ${radiusKm}km radius");
        return [];
      }

      // Fetch full driver details from Firestore
      List<UserModel> nearbyDrivers =
          await _fetchDriverDetailsFromIds(nearbyDriverIds);

      // Sort by distance from pickup location
      nearbyDrivers.sort((a, b) {
        if (a.location == null || b.location == null) return 0;

        double distanceA = calculateDistance(
          centerLat,
          centerLng,
          a.location!.latitude,
          a.location!.longitude,
        );
        double distanceB = calculateDistance(
          centerLat,
          centerLng,
          b.location!.latitude,
          b.location!.longitude,
        );
        return distanceA.compareTo(distanceB);
      });

      return nearbyDrivers;
    } catch (e) {
      print("Error fetching from Realtime Database: $e");
      return [];
    }
  }

  Future<List<UserModel>> _fetchDriverDetailsFromIds(
      List<String> driverIds) async {
    List<UserModel> driverDetails = [];

    for (String driverId in driverIds) {
      try {
        final result = await ref
            .read(tripsRepositoryProvider)
            .getDriverById(driverId: driverId);

        await result.fold(
          (failure) {
            print("Failed to fetch driver $driverId: $failure");
          },
          (driverData) {
            if (driverData != null &&
                driverData.driverInfo != null &&
                driverData.driverInfo!.availableStatus &&
                driverData.driverInfo!.approvedStatus == "approved") {
              // Update driver location from Realtime Database if needed
              driverDetails.add(driverData);
              print(
                  "Added driver: ${driverData.firstName} ${driverData.lastName}");
            }
          },
        );
      } catch (e) {
        print("Error fetching driver $driverId: $e");
      }
    }

    return driverDetails;
  }

// Real-time listener for driver location updates (optional)
  StreamSubscription<DatabaseEvent>? _activeDriversSubscription;

  void startListeningToActiveDrivers({
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    required Function(List<UserModel>) onDriversUpdated,
  }) {
    try {
      DatabaseReference activeDriversRef =
          FirebaseDatabase.instance.ref().child("activeDrivers");

      _activeDriversSubscription =
          activeDriversRef.onValue.listen((DatabaseEvent event) {
        if (event.snapshot.exists && event.snapshot.value != null) {
          _processActiveDriversUpdate(
            event.snapshot.value as Map<dynamic, dynamic>,
            centerLat,
            centerLng,
            radiusKm,
            onDriversUpdated,
          );
        }
      });
    } catch (e) {
      print("Error setting up real-time listener: $e");
    }
  }

  void _processActiveDriversUpdate(
    Map<dynamic, dynamic> activeDriversData,
    double centerLat,
    double centerLng,
    double radiusKm,
    Function(List<UserModel>) onDriversUpdated,
  ) async {
    List<String> nearbyDriverIds = [];

    activeDriversData.forEach((driverId, locationData) {
      if (locationData != null && locationData is Map) {
        var geoData = locationData['g'];
        if (geoData != null && geoData is List && geoData.length >= 2) {
          double driverLat = geoData[0].toDouble();
          double driverLng = geoData[1].toDouble();

          double distance =
              calculateDistance(centerLat, centerLng, driverLat, driverLng);
          double distanceKm = distance / 1000;

          if (distanceKm <= radiusKm) {
            nearbyDriverIds.add(driverId.toString());
          }
        }
      }
    });

    List<UserModel> nearbyDrivers =
        await _fetchDriverDetailsFromIds(nearbyDriverIds);
    onDriversUpdated(nearbyDrivers);
  }

  void stopListeningToActiveDrivers() {
    _activeDriversSubscription?.cancel();
    _activeDriversSubscription = null;
  }

// Calculate estimated fare based on distance and vehicle type
  double calculateEstimatedFare({
    required int distanceMeters,
    required int durationSeconds,
    required String vehicleType,
    required bool isStopover,
  }) {
    double baseFare = 5.0; // Base fare in MRU
    double perKmRate = 2.0; // Rate per kilometer
    double perMinuteRate = 0.5; // Rate per minute

    // Adjust rates based on vehicle type
    switch (vehicleType.toLowerCase()) {
      case 'suv':
      case 'comfort':
        baseFare *= 1.3;
        perKmRate *= 1.3;
        break;
      case 'luxury':
        baseFare *= 1.6;
        perKmRate *= 1.6;
        break;
      default:
        break;
    }

    double distanceKm = distanceMeters / 1000.0;
    double durationMinutes = durationSeconds / 60.0;

    double fare =
        baseFare + (distanceKm * perKmRate) + (durationMinutes * perMinuteRate);

    if (isStopover) {
      fare += 10.0;
    }

    return fare;
  }

// Send notification to driver about new trip request
  Future<void> sendTripNotificationToDriver({
    required String driverDeviceToken,
    required TripModel trip,
  }) async {
    try {
      final result = await ref.read(tripsRepositoryProvider).getAccessToken();

      await result.fold(
        (failure) {
          print("Failed to get access token: $failure");
        },
        (accessToken) async {
          String dropOffString = trip.destinationAddressNames.join(', ');

          final notificationResult = await ref
              .read(tripsRepositoryProvider)
              .sendTripCallNotification(
                user: trip.user,
                deviceRegistrationToken: driverDeviceToken,
                userTripRequestId: trip.id,
                serverAccessTokenKey: accessToken,
                dropOffString: dropOffString,
                locationName: trip.userPickupLocation.locationName ?? "Unknown",
              );

          await notificationResult.fold(
            (failure) {
              print("Failed to send notification: $failure");
            },
            (success) {
              print(
                  "Notification sent successfully to driver: ${trip.driver.firstName}");
            },
          );
        },
      );
    } catch (e) {
      print("Error sending notification to driver: $e");
    }
  }

// Clean up resources
  @override
  void dispose() {
    stopListeningToActiveDrivers();
    super.dispose();
  }
}

final tripsNotifierProvider =
    StateNotifierProvider<TripsNotifier, TripsState>((ref) {
  return TripsNotifier(ref);
});
