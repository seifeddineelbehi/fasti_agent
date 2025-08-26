import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

String calculateBottleAge(int productionYear) {
  int currentYear = DateTime.now().year;
  int age = currentYear - productionYear;
  return "$age Year${age > 1 ? 's' : ''} old";
}

Shimmer shimmeredWidget() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[200]!,
    child: Container(
      width: 1.sw,
      height: 80.sp,
      decoration: BoxDecoration(
        color: Colors.grey[400],
      ),
    ),
  );
}

double calculateDistance(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  const earthRadius = 6371000; // meters
  final dLat = _degreeToRadian(endLatitude - startLatitude);
  final dLon = _degreeToRadian(endLongitude - startLongitude);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreeToRadian(startLatitude)) *
          cos(_degreeToRadian(endLatitude)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double _degreeToRadian(double degree) {
  return degree * pi / 180;
}

Future<Uint8List> compressImage(File imageFile, {int maxSizeKB = 500}) async {
  // Read the image
  Uint8List imageBytes = await imageFile.readAsBytes();
  img.Image? image = img.decodeImage(imageBytes);

  if (image == null) throw Exception('Failed to decode image');

  // Resize image if it's too large (max 800x800 to reduce file size)
  if (image.width > 800 || image.height > 800) {
    image = img.copyResize(
      image,
      width: image.width > image.height ? 800 : null,
      height: image.height > image.width ? 800 : null,
    );
  }

  // Compress with different quality levels until we reach target size
  int quality = 85;
  Uint8List compressedBytes;

  do {
    compressedBytes =
        Uint8List.fromList(img.encodeJpg(image, quality: quality));
    quality -= 10;
  } while (compressedBytes.length > maxSizeKB * 1024 && quality > 10);

  return compressedBytes;
}

double calculateEconomicDisplayedPrice(
    int distanceMeters, double kmPrice, double lessKmPrice) {
  final distanceKm = distanceMeters / 1000;

  if (distanceKm <= 2.5) {
    return lessKmPrice;
  } else {
    // Subtract 2.5km base, then round up remaining km
    final extraDistance = distanceKm - 2.5;
    final totalPrice = lessKmPrice + (extraDistance * kmPrice);
    return totalPrice.ceil() * 1.0;
  }
}

double calculateBasePrice(int distanceMeters, double kmPrice) {
  final distanceKm = distanceMeters / 1000;

  if (distanceKm <= 2.5) {
    return 800;
  } else {
    final extraDistance = (distanceKm - 2.5).ceil();
    return 800 + (extraDistance * kmPrice);
  }
}

double calculateLuxuryPrice({
  required int distanceMeters,
  required double kmPrice,
  required int luxuryPercentage,
  required double lessKmPrice,
}) {
  final basePrice = calculateBasePrice(distanceMeters, kmPrice);
  return basePrice + (basePrice * luxuryPercentage / 100);
}

double calculateLuxurySuvPrice({
  required int distanceMeters,
  required double kmPrice,
  required int luxurySuvPercentage,
  required double lessKmPrice,
}) {
  final basePrice = calculateBasePrice(distanceMeters, kmPrice);
  return basePrice + (basePrice * luxurySuvPercentage / 100);
}

Size getDesignSize(double screenWidth) {
  // Extra small phones (very narrow screens)
  if (screenWidth < 320) {
    return const Size(320, 568);
  }
  // Small phones (iPhone SE, older Android phones)
  else if (screenWidth < 375) {
    return const Size(360, 640);
  }
  // Standard small phones (iPhone 12 mini, Pixel 5)
  else if (screenWidth < 400) {
    return const Size(375, 667);
  }
  // Medium phones (iPhone 12/13/14, most Android phones)
  else if (screenWidth < 430) {
    return const Size(414, 896);
  }
  // Large phones (iPhone 12/13/14 Pro Max, large Android phones)
  else if (screenWidth < 480) {
    return const Size(428, 926);
  }
  // Small tablets / Large phones in landscape
  else if (screenWidth < 600) {
    return const Size(480, 854);
  }
  // Medium tablets (iPad mini, small Android tablets)
  else if (screenWidth < 768) {
    return const Size(600, 960);
  }
  // Standard tablets (iPad, most Android tablets)
  else if (screenWidth < 1024) {
    return const Size(768, 1024);
  }
  // Large tablets (iPad Pro 11")
  else if (screenWidth < 1200) {
    return const Size(834, 1194);
  }
  // Extra large tablets (iPad Pro 12.9")
  else if (screenWidth < 1400) {
    return const Size(1024, 1366);
  }
  // Desktop/Web (small desktop screens)
  else if (screenWidth < 1920) {
    return const Size(1366, 768);
  }
  // Large desktop screens
  else {
    return const Size(1920, 1080);
  }
}

Future<void> requestNotificationPermission() async {
  // iOS and Android 13+ require permission
  final messaging = FirebaseMessaging.instance;

  // iOS-specific
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('⚠️ User granted provisional permission');
  } else {
    print('❌ User declined or has not accepted permission');
  }

  // Android 13+ requires runtime permission via permission_handler
  if (await Permission.notification.isDenied ||
      await Permission.notification.isPermanentlyDenied) {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      print('✅ Notification permission granted (Android)');
    } else {
      print('❌ Notification permission denied (Android)');
    }
  }
}

void popUntilNamed(BuildContext context, String routeName) {
  while (GoRouter.of(context)
      .routerDelegate
      .currentConfiguration
      .matches
      .isNotEmpty) {
    final currentRoute =
        GoRouter.of(context).routerDelegate.currentConfiguration.matches.last;
    if (currentRoute.matchedLocation == routeName) {
      break;
    }
    if (context.canPop()) {
      context.pop();
    } else {
      break;
    }
  }
}

double calculateStopoverFareAdjustment({
  required int stopoverElapsedSeconds,
  required double minutePrice,
}) {
  const int freeStopoverSeconds = 180;

  if (stopoverElapsedSeconds <= freeStopoverSeconds) return 0.0;

  int extraSeconds = stopoverElapsedSeconds - freeStopoverSeconds;
  double pricePerSecond = minutePrice / 60;

  double result = extraSeconds * pricePerSecond;
  return double.parse(result.toStringAsFixed(1));
}

DateTime parseDate(String dateString) {
  return DateTime.parse(dateString);
}

String formatDateTimeWithTime(String dateString) {
  final dateTime = parseDate(dateString);
  return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
}

String formatDateOnly(String dateString) {
  final dateTime = parseDate(dateString);
  return DateFormat('yyyy/MM/dd').format(dateTime);
}

String formatRoleName(String role) {
  return role
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

String formatPermissionName(String permission) {
  return permission
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

Color getRoleColor(String role) {
  switch (role) {
    case 'super_admin':
      return Colors.purple;
    case 'car_agent':
      return Colors.blue;
    case 'trip_agent':
      return Colors.green;
    case 'user_support_agent':
      return Colors.orange;
    case 'driver_manager':
      return Colors.teal;
    default:
      return Colors.grey;
  }
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

String formatLastLogin(DateTime? lastLogin) {
  return lastLogin != null ? formatDate(lastLogin) : 'Never';
}
