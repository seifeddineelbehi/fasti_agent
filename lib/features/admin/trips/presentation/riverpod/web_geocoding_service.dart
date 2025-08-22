import 'dart:async';
import 'dart:js' as js;
import 'dart:math';

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

class WebGeocodingService {
  static bool _isInitialized = false;
  static Function(String?)? _poiCallback;

  static Future<void> initialize({required String apiKey}) async {
    if (_isInitialized) return;

    // Inject all JavaScript functions
    _injectJavaScriptFunctions();

    // Set up the callback function for receiving POI names from JavaScript
    js.context['sendPOINameToFlutter'] = js.allowInterop((String? poiName) {
      print('Received POI from JS: $poiName');
      if (_poiCallback != null) {
        _poiCallback!(poiName);
      }
    });

    _isInitialized = true;
    print("WebGeocodingService initialized");
  }

  // Inject all JavaScript functions into the page
  static void _injectJavaScriptFunctions() {
    final jsCode = '''
      // Keep your existing getPlaceName function
      window.getPlaceName = async function(lat, lng, callback) {
        try {
          const latlng = { lat: parseFloat(lat), lng: parseFloat(lng) };

          const geocoder = new google.maps.Geocoder();
          geocoder.geocode({ location: latlng }, async (results, status) => {
            let fallbackAddress = null;
            if (status === "OK" && results[0]) {
              fallbackAddress = results[0].formatted_address;
            }

            let placeName = null;

            try {
              const { Place } = await google.maps.importLibrary("places");

              const request = { 
                locationRestriction: {
                  center: latlng,
                  radius: 100,
                },
                maxResultCount: 3,
                includedPrimaryTypes: ['point_of_interest'],
              };

              const result = await Place.searchNearby(request);
              const { places: nearbyPlaces } = result;

              if (nearbyPlaces && nearbyPlaces.length > 0) {
                placeName = nearbyPlaces[0].displayName?.text || nearbyPlaces[0].formattedAddress;
              }

              if (placeName) {
                callback({ name: placeName, address: placeName });
              } else if (fallbackAddress) {
                callback({ name: fallbackAddress, address: fallbackAddress });
              } else {
                callback(null);
              }
            } catch(e) {
              console.error("Nearby search error:", e);
              if (fallbackAddress) {
                callback({ name: fallbackAddress, address: fallbackAddress });
              } else {
                callback(null);
              }
            }
          });
        } catch (error) {
          console.error("Error in getPlaceName:", error);
          callback(null);
        }
      };

      // Helper function for checking icon mouse events
      function isIconMouseEvent(e) {
        return "placeId" in e;
      }

      // Click event handler class
      class ClickEventHandler {
        constructor(map, origin) {
          this.origin = origin;
          this.map = map;
          this.placesService = new google.maps.places.PlacesService(map);

          // Listen for clicks on the map
          this.map.addListener("click", this.handleClick.bind(this));
          console.log("ClickEventHandler initialized successfully");
        }

        handleClick(event) {
          console.log("JavaScript map clicked at: " + event.latLng);

          // If the event has a placeId, use it
          if (isIconMouseEvent(event)) {
            console.log("You clicked on place:" + event.placeId);
            event.stop();
            if (event.placeId) {
              this.getPlaceInformation(event.placeId);
            }
          } else {
            console.log("No POI clicked");
            // No POI clicked, send null to Flutter
            if (window.sendPOINameToFlutter) {
              window.sendPOINameToFlutter(null);
            }
          }
        }

        getPlaceInformation(placeId) {
          console.log("Getting place information for:", placeId);

          this.placesService.getDetails({ placeId: placeId }, (place, status) => {
            if (status === "OK" && place && place.name) {
              console.log("Place name:", place.name);

              // Send the place name to Flutter
              if (window.sendPOINameToFlutter) {
                window.sendPOINameToFlutter(place.name);
              }
            } else {
              console.log("Failed to get place details:", status);
              if (window.sendPOINameToFlutter) {
                window.sendPOINameToFlutter(null);
              }
            }
          });
        }
      }

      // Global variables
      window.jsMap = null;
      window.clickHandler = null;
      window.clickLat = null;
      window.clickLng = null;

      // Initialize JavaScript map that matches Flutter map position
      window.initJSMap = function(lat, lng, zoom) {
        console.log("Initializing JS map at:", lat, lng, "zoom:", zoom);

        // Create a hidden JavaScript Google Map
        const mapElement = document.getElementById('js-map');
        if (!mapElement) {
          console.error("js-map element not found");
          return;
        }

        window.jsMap = new google.maps.Map(mapElement, {
          center: { lat: lat, lng: lng },
          zoom: zoom,
          disableDefaultUI: true,
        });

        // Initialize click handler
        const origin = { lat: lat, lng: lng };
        window.clickHandler = new ClickEventHandler(window.jsMap, origin);

        console.log("JS map and click handler initialized");
      };

      // Sync JavaScript map with Flutter map position
      window.syncMapPosition = function(lat, lng, zoom) {
        if (window.jsMap) {
          window.jsMap.setCenter({ lat: lat, lng: lng });
          if (zoom) {
            window.jsMap.setZoom(zoom);
          }
        }
      };

     window.simulateMapClick = async function(lat, lng) {
    console.log("Simulate click received:", lat, lng);
    
    // Use parameters if provided, otherwise use global variables
    const clickLat = lat || window.clickLat;
    const clickLng = lng || window.clickLng;
    console.log("Using coordinates:", clickLat, clickLng);

    // Wait until map is ready
    if (!window.jsMap || !window.clickHandler) {
        console.warn("Map not ready yet, retrying in 500ms...");
        setTimeout(() => window.simulateMapClick(clickLat, clickLng), 500);
        return;
    }

    const clickLatLng = new google.maps.LatLng(clickLat, clickLng);
    console.log("Clicking at:", clickLatLng.toString());

    try {
        const { Place } = await google.maps.importLibrary("places");
        
        const request = {
            fields: ['displayName', 'formattedAddress'], // Add the missing fields array
            locationRestriction: {
                center: clickLatLng,
                radius: 10
            },
            
            maxResultCount: 1,
        };

        const result = await Place.searchNearby(request);
        const place = result.places?.[0];

        if (place) {
            const name = place.displayName?.text || place.formattedAddress;
            console.log("Found POI:", name);
            if (window.sendPOINameToFlutter) window.sendPOINameToFlutter(name);
        } else {
            console.log("No POI found");
            if (window.sendPOINameToFlutter) window.sendPOINameToFlutter(null);
        }
    } catch (e) {
        console.error("Nearby search error:", e);
        if (window.sendPOINameToFlutter) window.sendPOINameToFlutter(null);
    }
};
    ''';

    // Create a script element and inject the code
    js.context.callMethod('eval', [jsCode]);
  }

  // Set callback to receive POI names
  static void setPOICallback(Function(String?) callback) {
    _poiCallback = callback;
  }

  // Initialize the hidden JavaScript map
  static void initializeJSMap(double lat, double lng, double zoom) {
    double safeLat = roundDouble(lat, 6); // 6 decimal places
    double safeLng = roundDouble(lng, 6);
    js.context.callMethod('initJSMap', [safeLat, safeLng, zoom]);
  }

  // Sync JavaScript map position with Flutter map
  static void syncMapPosition(double lat, double lng, double zoom) {
    double safeLat = roundDouble(lat, 6); // 6 decimal places
    double safeLng = roundDouble(lng, 6);
    js.context.callMethod('syncMapPosition', [safeLat, safeLng, zoom]);
  }

  // Simulate a click on the JavaScript map from Flutter coordinates
  static void simulateMapClick(double lat, double lng) {
    print("Flutter: Setting coordinates: $lat, $lng");

    // Set coordinates as global variables first
    js.context['clickLat'] = lat;
    js.context['clickLng'] = lng;

    // Call the function with parameters for better reliability
    js.context.callMethod('simulateMapClick', [lat, lng]);
  }

  // Get place name using coordinates (alternative method)
  static void getPlaceName(
      double lat, double lng, Function(Map<String, String>?) callback) {
    js.context.callMethod('getPlaceName', [
      lat,
      lng,
      js.allowInterop((result) {
        if (result != null) {
          callback({
            'name': result['name']?.toString() ?? '',
            'address': result['address']?.toString() ?? '',
          });
        } else {
          callback(null);
        }
      })
    ]);
  }
}
