// If you want more robust connectivity checking, use this enhanced version
// You'll need to add connectivity_plus: ^6.0.5 to your pubspec.yaml

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectivityStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> get isConnected async {
    if (kIsWeb) {
      return _checkWebConnectivity();
    }

    try {
      final result = await _connectivity.checkConnectivity();
      return result.any((connection) =>
          connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.ethernet);
    } catch (e) {
      if (kDebugMode) {
        print('Connectivity check failed: $e');
      }
      // Fallback to true if connectivity check fails
      return true;
    }
  }

  @override
  Stream<bool> get connectivityStream {
    if (kIsWeb) {
      // For web, return a stream that always indicates connected
      return Stream.periodic(const Duration(seconds: 30), (_) => true);
    }

    return _connectivity.onConnectivityChanged.map((results) {
      return results.any((result) =>
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet);
    });
  }

  Future<bool> _checkWebConnectivity() async {
    try {
      // For web, we'll use a simple approach
      // You could enhance this with actual network requests if needed
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Web connectivity check failed: $e');
      }
      return true;
    }
  }
}
