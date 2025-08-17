import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/riverpod/saved_places/saved_places_provider.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/location_model.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// You'll need to import your saved places provider
// import 'package:fasti_dashboard/features/saved_places/presentation/riverpod/saved_places_provider.dart';

class SavedPlacesPage extends ConsumerStatefulWidget {
  const SavedPlacesPage({super.key});

  @override
  ConsumerState<SavedPlacesPage> createState() => _SavedPlacesPageState();
}

class _SavedPlacesPageState extends ConsumerState<SavedPlacesPage> {
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref.read(savedPlacesProvider.notifier).getAllSavedPlaces();
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

  void _navigateToAddSavedPlace() {
    AddSavedPlacePageRoute().go(context);
  }

  Future<void> _deleteSavedPlace(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Saved Place'),
          content:
              const Text('Are you sure you want to delete this saved place?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      final success =
          await ref.read(savedPlacesProvider.notifier).deleteSavedPlace(index);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved place deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedPlaces = ref.watch(savedPlacesProvider).savedPlaces ?? [];
    final filteredPlaces = savedPlaces.where((place) {
      final label = place.label.toLowerCase();
      final subLabel = place.subLabel.toLowerCase();
      return label.contains(_searchQuery) || subLabel.contains(_searchQuery);
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
                  const PageHeader(
                    title: 'Saved Places',
                    description: 'Manage your frequently used locations.',
                  ),
                  const Gap(16),

                  // Search and Add Row
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search saved places...',
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
                      CustomButtons.simpleLongButtonWithIcon(
                        onPressed: _navigateToAddSavedPlace,
                        text: "Add New Place",
                        icon: Icon(Icons.add_location),
                        width: 160.w,
                        height: 45.h,
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Header with stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textBoldWeight700(
                            text: "Saved Places Management",
                            fontSize: 28.sp,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.sp),
                          CommonText.textBoldWeight400(
                            text:
                                "${savedPlaces.length} saved places • ${filteredPlaces.length} shown",
                            fontSize: 16.sp,
                            color: Colors.grey[600]!,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 24.sp),

                  // Places grid/list
                  Expanded(
                    child: filteredPlaces.isEmpty
                        ? _buildEmptyState()
                        : _buildPlacesGrid(filteredPlaces),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.sp),
          CommonText.textBoldWeight600(
            text: _searchQuery.isEmpty
                ? "No saved places yet"
                : "No places found",
            fontSize: 18.sp,
            color: Colors.grey[600]!,
          ),
          SizedBox(height: 8.sp),
          CommonText.textBoldWeight400(
            text: _searchQuery.isEmpty
                ? "Add your frequently used locations for quick access"
                : "Try adjusting your search terms",
            fontSize: 14.sp,
            color: Colors.grey[500]!,
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty) ...[
            SizedBox(height: 24.sp),
            CustomButtons.simpleLongButtonWithIcon(
              onPressed: _navigateToAddSavedPlace,
              text: "Add First Place",
              icon: Icon(Icons.add_location),
              width: 160.w,
              height: 45.h,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildPlacesGrid(List<LocationModel> places) {
    return GridView.builder(
      padding: EdgeInsets.all(16.sp),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.sp,
        mainAxisSpacing: 16.sp,
        childAspectRatio: 1.2,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return _buildPlaceCard(place, index);
      },
    );
  }

  Widget _buildPlaceCard(LocationModel place, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40.sp,
                  height: 40.sp,
                  decoration: BoxDecoration(
                    color: _getPlaceTypeColor(place.label),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Icon(
                    _getPlaceTypeIcon(place.label),
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, size: 20.sp),
                  onSelected: (value) {
                    switch (value) {
                      case 'delete':
                        _deleteSavedPlace(index);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.sp),
            CommonText.textBoldWeight600(
              text: place.label,
              fontSize: 16.sp,
              color: Colors.black,
            ),
            SizedBox(height: 4.sp),
            CommonText.textBoldWeight400(
              text: place.subLabel,
              fontSize: 12.sp,
              color: Colors.grey[600]!,
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.sp,
                vertical: 4.sp,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4.sp),
              ),
              child: CommonText.textBoldWeight400(
                text:
                    "${place.latitude.toStringAsFixed(4)}, ${place.longitude.toStringAsFixed(4)}",
                fontSize: 10.sp,
                color: Colors.grey[600]!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPlaceTypeColor(String label) {
    switch (label.toLowerCase()) {
      case 'home':
        return Colors.green;
      case 'office':
      case 'work':
        return Colors.blue;
      case 'airport':
        return Colors.purple;
      case 'hospital':
        return Colors.red;
      case 'mall':
      case 'shopping':
        return Colors.orange;
      default:
        return Palette.mainColor;
    }
  }

  IconData _getPlaceTypeIcon(String label) {
    switch (label.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'office':
      case 'work':
        return Icons.business;
      case 'airport':
        return Icons.flight;
      case 'hospital':
        return Icons.local_hospital;
      case 'mall':
      case 'shopping':
        return Icons.shopping_bag;
      default:
        return Icons.location_on;
    }
  }
}
