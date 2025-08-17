import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/riverpod/rents_provider.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_request_action_dialog.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_request_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentPage extends ConsumerStatefulWidget {
  final String rentId;
  const RentPage({super.key, required this.rentId});

  @override
  ConsumerState<RentPage> createState() => _RentPageState();
}

class _RentPageState extends ConsumerState<RentPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      // TODO: Replace with actual provider call
      await ref
          .read(rentsNotifierProvider.notifier)
          .getRentById(rentId: widget.rentId);

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = ref.watch(rentsNotifierProvider).rent;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.mainDarkColor,
        ),
      );
    } else {
      if (request == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Rental Request Details')),
          body: const Center(
              child: Text('No rental request information available')),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title:
              Text('Rental Request Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          actions: [
            // Action buttons for pending requests
            if (request.status.toLowerCase() == 'pending') ...[
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: TextButton.icon(
                  onPressed: () => showRentalRequestActionDialog(
                    context,
                    ref,
                    request,
                    request.status,
                    'accept',
                  ),
                  icon: const Icon(Icons.check, color: Colors.green),
                  label: const Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: TextButton.icon(
                  onPressed: () => showRentalRequestActionDialog(
                    context,
                    ref,
                    request,
                    request.status,
                    'refuse',
                  ),
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text(
                    'Refuse',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Request Header
              buildRentalRequestHeader(request),
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
                              Expanded(child: buildRequestDetailsCard(request)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: buildCustomerDetailsCard(request)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildCarDetailsCard(request)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: buildRequestTimelineCard(request)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child:
                                      Container()), // Placeholder for future card
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
                              Expanded(child: buildRequestDetailsCard(request)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: buildCustomerDetailsCard(request)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildCarDetailsCard(request)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: buildRequestTimelineCard(request)),
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
                        buildRequestDetailsCard(request),
                        SizedBox(height: 16.h),
                        buildCustomerDetailsCard(request),
                        SizedBox(height: 16.h),
                        buildCarDetailsCard(request),
                        SizedBox(height: 16.h),
                        buildRequestTimelineCard(request),
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
