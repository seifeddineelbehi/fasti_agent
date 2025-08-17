import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/riverpod/rents_provider.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_requests_table_widget.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class RentsPage extends ConsumerStatefulWidget {
  const RentsPage({super.key});

  @override
  ConsumerState<RentsPage> createState() => _RentsPageState();
}

class _RentsPageState extends ConsumerState<RentsPage> {
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

      await ref.read(rentsNotifierProvider.notifier).getAllRents();

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

  @override
  Widget build(BuildContext context) {
    final requests = ref.watch(rentsNotifierProvider).rents ?? [];

    // Filter by search query and status
    final filteredRequests = requests.where((request) {
      final customerName =
          '${request.user.firstName} ${request.user.lastName}'.toLowerCase();
      final carName = '${request.car.brand} ${request.car.model}'.toLowerCase();

      final matchesSearch = customerName.contains(_searchQuery) ||
          carName.contains(_searchQuery) ||
          request.id.toLowerCase().contains(_searchQuery);

      final matchesStatus = _statusFilter == 'all' ||
          request.status.toLowerCase() == _statusFilter.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();

    // Calculate stats
    final pendingCount =
        requests.where((r) => r.status.toLowerCase() == 'pending').length;
    final acceptedCount =
        requests.where((r) => r.status.toLowerCase() == 'confirmed').length;
    final refusedCount =
        requests.where((r) => r.status.toLowerCase() == 'notconfirmed').length;
    final totalRevenue = requests
        .where((r) => r.status.toLowerCase() == 'confirmed')
        .fold(0.0, (sum, request) => sum + request.totalCost);

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
                    title: 'Rental Requests',
                    description: 'Manage car rental requests from customers.',
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
                                'Search by customer, car, or request ID...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
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
                                value: 'confirmed', child: Text('Confirmed')),
                            DropdownMenuItem(
                                value: 'confirmed',
                                child: Text('Not Confirmed')),
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

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Requests',
                          requests.length.toString(),
                          Icons.directions_car,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Pending',
                          pendingCount.toString(),
                          Icons.schedule,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Accepted',
                          acceptedCount.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Refused',
                          refusedCount.toString(),
                          Icons.cancel,
                          Colors.red,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Total Revenue',
                          '${totalRevenue.toStringAsFixed(2)} MRU',
                          Icons.attach_money,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Results Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${filteredRequests.length} of ${requests.length} requests',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_statusFilter != 'all' || _searchQuery.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _statusFilter = 'all';
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear Filters'),
                        ),
                    ],
                  ),
                  const Gap(16),

                  // Table
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: RentalRequestsTableWidget(
                        requests: filteredRequests,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
