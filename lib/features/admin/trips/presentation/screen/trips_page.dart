import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/trips/trips_provider.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trips_table_widget.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TripsPage extends ConsumerStatefulWidget {
  const TripsPage({super.key});

  @override
  ConsumerState<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends ConsumerState<TripsPage> {
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref.read(tripsNotifierProvider.notifier).getAllTrips();
      setState(() {
        isLoading = false;
      });
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToAddTrip() {
    AddTripPageRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final trips = ref.watch(tripsNotifierProvider).trips ?? [];

    // Filter trips based on search query and status
    final filteredTrips = trips.where((trip) {
      final userFullName =
          '${trip.user.firstName ?? ''} ${trip.user.lastName ?? ''}'
              .toLowerCase();
      final driverFullName =
          '${trip.driver.firstName ?? ''} ${trip.driver.lastName ?? ''}'
              .toLowerCase();
      final origin = trip.originAddressName.toLowerCase();
      final destination = trip.destinationAddressNames.isNotEmpty
          ? trip.destinationAddressNames.first.toLowerCase()
          : '';

      final matchesSearch = userFullName.contains(_searchQuery) ||
          driverFullName.contains(_searchQuery) ||
          origin.contains(_searchQuery) ||
          destination.contains(_searchQuery) ||
          trip.id.toLowerCase().contains(_searchQuery);

      final matchesStatus = _statusFilter == 'all' ||
          trip.status.toLowerCase() == _statusFilter.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();

    // Calculate stats
    final totalTrips = trips.length;
    final endedTrips =
        trips.where((t) => t.status.toLowerCase() == 'ended').length;
    final onTripTrips = trips
        .where((t) =>
            t.status.toLowerCase() == 'ontrip' ||
            t.status.toLowerCase() == 'DriverArrived' ||
            t.status.toLowerCase() == 'startStopOver' ||
            t.status.toLowerCase() == 'pauseStopOver' ||
            t.status.toLowerCase() == 'resumeStopOver' ||
            t.status.toLowerCase() == 'awaiting_customer_confirmation')
        .length;
    final pendingTrips =
        trips.where((t) => t.status.toLowerCase() == 'pending').length;
    final notAcceptedTrips =
        trips.where((t) => t.status.toLowerCase() == 'not accepted').length;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Palette.mainDarkColor,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[50],
            body: ContentView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    title: 'Trips',
                    description: 'Manage all trips and bookings.',
                  ),
                  const Gap(16),

                  // Search and Filter Row
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText:
                                'Search trips by user, driver, location...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _statusFilter,
                          decoration: InputDecoration(
                            labelText: 'Filter by Status',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'all', child: Text('All Status')),
                            DropdownMenuItem(
                                value: 'pending', child: Text('Pending')),
                            DropdownMenuItem(
                                value: 'accepted', child: Text('Accepted')),
                            DropdownMenuItem(
                                value: 'not accepted',
                                child: Text('Not Accepted')),
                            DropdownMenuItem(
                                value: 'driverarrived',
                                child: Text('Driver Arrived')),
                            DropdownMenuItem(
                                value: 'ontrip', child: Text('On Trip')),
                            DropdownMenuItem(
                                value: 'awaiting_customer_confirmation',
                                child: Text('Awaiting Confirmation')),
                            DropdownMenuItem(
                                value: 'ended', child: Text('Ended')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _statusFilter = value ?? 'all';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textBoldWeight700(
                            text: "Trips Management",
                            fontSize: 28.sp,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.sp),
                          CommonText.textBoldWeight400(
                            text: "Manage and track all trip requests",
                            fontSize: 16.sp,
                            color: Colors.grey[600]!,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomButtons.simpleLongButtonWithIcon(
                            onPressed: () {
                              // Navigate to saved places page
                              SavedPlacesPageRoute().go(context);
                            },
                            text: "Saved Places",
                            icon: Icon(Icons.bookmark),
                            width: 140.w,
                            height: 45.h,
                          ),
                          SizedBox(width: 12.w),
                          CustomButtons.simpleLongButtonWithIcon(
                            onPressed: _navigateToAddTrip,
                            text: "Add New Trip",
                            icon: Icon(Icons.add),
                            width: 150.w,
                            height: 45.h,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 24.sp),
                  // Stats cards
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Total Trips',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  totalTrips.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Ended',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  endedTrips.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'On Trip',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  onTripTrips.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Pending',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pendingTrips.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Not Accepted',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notAcceptedTrips.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Trips table
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: TripsTableWidget(
                        trips: filteredTrips,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
