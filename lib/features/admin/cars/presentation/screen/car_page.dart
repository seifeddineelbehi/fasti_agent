import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/riverpod/cars_provider.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_availability_dialog.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarPage extends ConsumerStatefulWidget {
  final String carId;
  const CarPage({super.key, required this.carId});

  @override
  ConsumerState<CarPage> createState() => _CarPageState();
}

class _CarPageState extends ConsumerState<CarPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref
          .read(carsNotifierProvider.notifier)
          .getCarById(carId: widget.carId);
      setState(() {
        isLoading = false;
      });
    });
  }

  void _toggleAvailability() {
    final car = ref.read(carsNotifierProvider).car;
    if (car != null) {
      showCarAvailabilityDialog(context, ref, car.id, car.isAvailable);
    }
  }

  void _editCar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit car functionality coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = ref.watch(carsNotifierProvider).car;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Car Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Palette.mainDarkColor,
          ),
        ),
      );
    }

    if (car == null) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Car Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Car not found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'The requested car could not be loaded.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('${car.brand} ${car.model}',
            style: TextStyle(fontSize: 20.sp)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(car.isAvailable ? Icons.block : Icons.check_circle),
            onPressed: _toggleAvailability,
            tooltip: car.isAvailable ? 'Mark Unavailable' : 'Mark Available',
          ),
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   onPressed: _editCar,
          //   tooltip: 'Edit Car',
          // ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight - 32.h, // Account for padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Profile Header
                    buildCarHeader(car),
                    SizedBox(height: 24.h),

                    // Responsive Grid Layout
                    _buildResponsiveLayout(context, car, constraints.maxWidth),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(
      BuildContext context, dynamic car, double screenWidth) {
    if (screenWidth > 1400) {
      // Extra Large Desktop Layout - 4 columns for some rows
      return Column(
        children: [
          // First row - 3 columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCarInfoCard(car)),
              SizedBox(width: 16.w),
              Expanded(child: buildCarStatisticsCard(car)),
              SizedBox(width: 16.w),
              Expanded(
                  child: buildCarActionCard(
                car,
                onAvailabilityToggle: _toggleAvailability,
                onEdit: _editCar,
              )),
            ],
          ),
          SizedBox(height: 24.h),
          // Second row - 3 columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCarImagesCard(car)),
              // SizedBox(width: 16.w),
              // Expanded(child: buildCarMaintenanceCard(car)),
              // SizedBox(width: 16.w),
              // Expanded(child: buildCarBookingHistoryCard(car)),
            ],
          ),
          SizedBox(height: 24.h),
          // Third row - Full width
          buildCarRentalsCard(car),
        ],
      );
    } else if (screenWidth > 1200) {
      // Large Desktop Layout - 3 columns
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCarInfoCard(car)),
              SizedBox(width: 16.w),
              Expanded(child: buildCarStatisticsCard(car)),
              SizedBox(width: 16.w),
              Expanded(child: buildCarImagesCard(car)),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: buildCarActionCard(
                car,
                onAvailabilityToggle: _toggleAvailability,
                onEdit: _editCar,
              )),
              // SizedBox(width: 16.w),
              // Expanded(child: buildCarMaintenanceCard(car)),
              // SizedBox(width: 16.w),
              // Expanded(child: buildCarBookingHistoryCard(car)),
            ],
          ),
          SizedBox(height: 24.h),
          buildCarRentalsCard(car),
        ],
      );
    } else if (screenWidth > 768) {
      // Tablet Layout - 2 columns
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCarInfoCard(car)),
              SizedBox(width: 16.w),
              Expanded(child: buildCarStatisticsCard(car)),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCarImagesCard(car)),
              SizedBox(width: 16.w),
              Expanded(
                  child: buildCarActionCard(
                car,
                onAvailabilityToggle: _toggleAvailability,
                onEdit: _editCar,
              )),
            ],
          ),
          SizedBox(height: 24.h),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Expanded(child: buildCarMaintenanceCard(car)),
          //     // SizedBox(width: 16.w),
          //     Expanded(child: buildCarBookingHistoryCard(car)),
          //   ],
          // ),
          // SizedBox(height: 24.h),
          buildCarRentalsCard(car),
        ],
      );
    } else {
      // Mobile Layout - 1 column
      return Column(
        children: [
          buildCarInfoCard(car),
          SizedBox(height: 16.h),
          buildCarStatisticsCard(car),
          SizedBox(height: 16.h),
          buildCarActionCard(
            car,
            onAvailabilityToggle: _toggleAvailability,
            onEdit: _editCar,
          ),
          SizedBox(height: 16.h),
          buildCarImagesCard(car),
          // SizedBox(height: 16.h),
          // buildCarMaintenanceCard(car),
          // SizedBox(height: 16.h),
          // buildCarBookingHistoryCard(car),
          SizedBox(height: 16.h),
          buildCarRentalsCard(car),
        ],
      );
    }
  }
}
