import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/widget/driver_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverPage extends ConsumerStatefulWidget {
  final String driverId;
  const DriverPage({super.key, required this.driverId});

  @override
  ConsumerState<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends ConsumerState<DriverPage> {
  String? selectedImageUrl;
  bool isLoading = false;
  bool isPaymentLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref
          .read(driversNotifierProvider.notifier)
          .getDriverById(driverId: widget.driverId);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final driver = ref.watch(driversNotifierProvider).driver;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.mainDarkColor,
        ),
      );
    } else {
      if (driver == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Driver Details')),
          body: const Center(child: Text('No driver information available')),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Driver Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Driver Profile Header
                  buildDriverHeader(driver),
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
                                  Expanded(
                                      child:
                                          buildDriverInfoCard(driver, context)),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                      child: buildVehicleInfoCard(
                                          driver, context)),
                                  SizedBox(width: 16.w),
                                  Expanded(child: buildEarningsCard(driver)),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(child: buildRatingsCard(driver)),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: buildWalletPaymentsCard(
                                      driver,
                                      context,
                                      ref,
                                      onPaySingle: _handlePaySingle,
                                      onPayAll: _handlePayAll,
                                    ),
                                  ),
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
                                  Expanded(
                                      child:
                                          buildDriverInfoCard(driver, context)),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                      child: buildVehicleInfoCard(
                                          driver, context)),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(child: buildEarningsCard(driver)),
                                  SizedBox(width: 16.w),
                                  Expanded(child: buildRatingsCard(driver)),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            buildWalletPaymentsCard(
                              driver,
                              context,
                              ref,
                              onPaySingle: _handlePaySingle,
                              onPayAll: _handlePayAll,
                            ),
                          ],
                        );
                      } else {
                        // Mobile Layout - 1 column
                        return Column(
                          children: [
                            buildDriverInfoCard(driver, context),
                            SizedBox(height: 16.h),
                            buildVehicleInfoCard(driver, context),
                            SizedBox(height: 16.h),
                            buildEarningsCard(driver),
                            SizedBox(height: 16.h),
                            buildRatingsCard(driver),
                            SizedBox(height: 16.h),
                            buildWalletPaymentsCard(
                              driver,
                              context,
                              ref,
                              onPaySingle: _handlePaySingle,
                              onPayAll: _handlePayAll,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // Loading overlay for payments
            if (isPaymentLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              color: Palette.mainDarkColor),
                          SizedBox(height: 16.h),
                          Text('Processing payment...'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }
  }

  Future<void> _handlePaySingle(String tripId) async {
    try {
      bool isLoaded = false;
      // Show confirmation dialog
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(text: "Confirm Payment"),
            content: CommonText.textBoldWeight500(
              text: "Are you sure you want to mark this trip payment as paid?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Palette.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButtons.simpleButton(
                width: 160,
                text: "Confirm All",
                isLoading: isLoaded,
                onPressed: isLoaded
                    ? null
                    : () async {
                        setStateDialog(() {
                          isLoaded = true;
                        });
                        await ref
                            .read(driversNotifierProvider.notifier)
                            .payWalletTrip(tripId);
                        setStateDialog(() {
                          isLoaded = false;
                        });
                        Navigator.of(context).pop();
                      },
              ),
            ],
          );
        }),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error processing payment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Method to handle pay all
  Future<void> _handlePayAll() async {
    final driver = ref.read(driversNotifierProvider).driver;
    if (driver == null) return;

    final unpaidPayments = driver.driverInfo!.walletTripPayments
        .where((payment) => !payment.isPaidByAdmin)
        .toList();

    if (unpaidPayments.isEmpty) return;
    bool isLoaded = false;
    try {
      // Show confirmation dialog
      await showDialog<bool>(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: CommonText.textBoldWeight700(text: "Confirm All Payments"),
            content: CommonText.textBoldWeight500(
              text:
                  "Are you sure you want to mark all ${unpaidPayments.length} outstanding payments as paid?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Palette.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButtons.simpleButton(
                width: 160,
                text: "Confirm All",
                isLoading: isLoaded,
                onPressed: isLoaded
                    ? null
                    : () async {
                        setStateDialog(() {
                          isLoaded = true;
                        });
                        await ref
                            .read(driversNotifierProvider.notifier)
                            .payAllWalletTrips();
                        setStateDialog(() {
                          isLoaded = false;
                        });
                        Navigator.of(context).pop();
                      },
              ),
            ],
          );
        }),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error processing payments: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
