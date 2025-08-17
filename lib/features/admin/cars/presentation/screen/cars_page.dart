import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/riverpod/cars_provider.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/cars_table_widget.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CarsPage extends ConsumerStatefulWidget {
  const CarsPage({super.key});

  @override
  ConsumerState<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends ConsumerState<CarsPage> {
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedAvailabilityFilter =
      'all'; // 'all', 'available', 'unavailable'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref.read(carsNotifierProvider.notifier).getAllCars();
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
    final cars = ref.watch(carsNotifierProvider).cars ?? [];

    // Filter by search query and availability
    final filteredCars = cars.where((car) {
      final carName = '${car.brand} ${car.model}'.toLowerCase();
      final typeMatch = car.type.toLowerCase().contains(_searchQuery);
      final nameMatch = carName.contains(_searchQuery);

      bool matchesSearch = nameMatch || typeMatch;

      bool matchesAvailability = true;
      if (_selectedAvailabilityFilter == 'available') {
        matchesAvailability = car.isAvailable;
      } else if (_selectedAvailabilityFilter == 'unavailable') {
        matchesAvailability = !car.isAvailable;
      }

      return matchesSearch && matchesAvailability;
    }).toList();

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
                  // Page Header with Add Button
                  Row(
                    children: [
                      const Expanded(
                        child: PageHeader(
                          title: 'Cars Management',
                          description:
                              'Manage rental cars inventory and availability.',
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          CreateCarPageRoute().go(context);
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add New Car',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.mainDarkColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
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
                            hintText: 'Search cars by brand, model, or type...',
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
                          value: _selectedAvailabilityFilter,
                          decoration: InputDecoration(
                            labelText: 'Filter by Availability',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'all', child: Text('All Cars')),
                            DropdownMenuItem(
                                value: 'available',
                                child: Text('Available Only')),
                            DropdownMenuItem(
                                value: 'unavailable',
                                child: Text('Unavailable Only')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedAvailabilityFilter = value ?? 'all';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Total Cars',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cars.length.toString(),
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
                                  'Available Cars',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cars
                                      .where((c) => c.isAvailable)
                                      .length
                                      .toString(),
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
                                  'Unavailable Cars',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cars
                                      .where((c) => !c.isAvailable)
                                      .length
                                      .toString(),
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Active Rentals',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cars
                                      .fold<int>(
                                          0,
                                          (total, car) =>
                                              total + car.rentalPeriods.length)
                                      .toString(),
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
                    ],
                  ),
                  const Gap(16),

                  // Cars Table
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: CarsTableWidget(
                        cars: filteredCars,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
