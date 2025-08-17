import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_page_widget.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_status_monitor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripPage extends ConsumerStatefulWidget {
  final String tripId;
  const TripPage({super.key, required this.tripId});

  @override
  ConsumerState<TripPage> createState() => _TripPageState();
}

class _TripPageState extends ConsumerState<TripPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref
          .read(tripsNotifierProvider.notifier)
          .getTripById(tripId: widget.tripId);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final trip = ref.watch(tripsNotifierProvider).trip;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.mainDarkColor,
        ),
      );
    } else {
      if (trip == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Trip Details')),
          body: const Center(child: Text('No trip information available')),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Trip Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Header
              buildTripHeader(trip),
              SizedBox(height: 24.h),

              // Trip Status Monitor Widget - New Addition
              TripStatusMonitorWidget(initialTrip: trip),
              SizedBox(height: 24.h),

              // Responsive Grid Layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;

                  if (screenWidth > 1200) {
                    // Desktop Layout - 3 columns
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildTripDetailsCard(trip)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserInfoCard(trip)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildDriverInfoCard(trip)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildRouteInfoCard(trip)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child:
                                      Container()), // Empty space for balance
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (screenWidth > 768) {
                    // Tablet Layout - 2 columns
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildTripDetailsCard(trip)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserInfoCard(trip)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildDriverInfoCard(trip)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildRouteInfoCard(trip)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  } else {
                    // Mobile Layout - 1 column
                    return Column(
                      children: [
                        buildTripDetailsCard(trip),
                        SizedBox(height: 16.h),
                        buildUserInfoCard(trip),
                        SizedBox(height: 16.h),
                        buildDriverInfoCard(trip),
                        SizedBox(height: 16.h),
                        buildRouteInfoCard(trip),
                        SizedBox(height: 16.h),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
