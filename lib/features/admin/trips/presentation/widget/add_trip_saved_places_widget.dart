import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTripSavedPlacesWidget extends StatefulWidget {
  final Function(LocationModel) onPlaceSelected;
  final List<LocationModel> savedPlaces;

  const AddTripSavedPlacesWidget({
    super.key,
    required this.onPlaceSelected,
    required this.savedPlaces,
  });

  @override
  State<AddTripSavedPlacesWidget> createState() =>
      _AddTripSavedPlacesWidgetState();
}

class _AddTripSavedPlacesWidgetState extends State<AddTripSavedPlacesWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationModel> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = widget.savedPlaces;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(AddTripSavedPlacesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update filtered places when savedPlaces changes
    if (widget.savedPlaces != oldWidget.savedPlaces) {
      _updateFilteredPlaces();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _updateFilteredPlaces() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredPlaces = widget.savedPlaces;
      } else {
        _filteredPlaces = widget.savedPlaces.where((place) {
          return place.label.toLowerCase().contains(query) ||
              place.subLabel.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _onSearchChanged() {
    _updateFilteredPlaces();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _filteredPlaces = widget.savedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textBoldWeight600(
          text: "Saved Places",
          fontSize: 16.sp,
          color: Colors.black,
        ),
        SizedBox(height: 12.sp),
        if (widget.savedPlaces.isNotEmpty) _buildSearchField(),
        if (widget.savedPlaces.isNotEmpty) SizedBox(height: 12.sp),
        Container(
          constraints: BoxConstraints(maxHeight: 300.h),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: widget.savedPlaces.isEmpty
              ? _buildEmptyState()
              : _filteredPlaces.isEmpty
              ? _buildNoResultsState()
              : _buildSavedPlacesList(_filteredPlaces),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search saved places...",
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.grey[400],
              size: 20.sp,
            ),
            onPressed: _clearSearch,
          )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 12.sp,
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_border,
          size: 48.sp,
          color: Colors.grey[400],
        ),
        SizedBox(height: 12.sp),
        CommonText.textBoldWeight400(
          text: "No saved places yet",
          fontSize: 14.sp,
          color: Colors.grey[600]!,
        ),
        SizedBox(height: 8.sp),
        CommonText.textBoldWeight400(
          text: "Add frequently used locations for quick access",
          fontSize: 12.sp,
          color: Colors.grey[500]!,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNoResultsState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 48.sp,
          color: Colors.grey[400],
        ),
        SizedBox(height: 12.sp),
        CommonText.textBoldWeight400(
          text: "No places found",
          fontSize: 14.sp,
          color: Colors.grey[600]!,
        ),
        SizedBox(height: 8.sp),
        CommonText.textBoldWeight400(
          text: "Try adjusting your search terms",
          fontSize: 12.sp,
          color: Colors.grey[500]!,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSavedPlacesList(List<LocationModel> places) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: places.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.sp),
      itemBuilder: (context, index) {
        final place = places[index];
        return _buildPlaceItem(place);
      },
    );
  }

  Widget _buildPlaceItem(LocationModel place) {
    final searchQuery = _searchController.text.toLowerCase().trim();

    return InkWell(
      onTap: () => widget.onPlaceSelected(place),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(6.sp),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 36.sp,
              height: 36.sp,
              decoration: BoxDecoration(
                color: Palette.mainColor,
                borderRadius: BorderRadius.circular(18.sp),
              ),
              child: Icon(
                Icons.location_on,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHighlightedText(
                    place.label,
                    searchQuery,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  SizedBox(height: 2.sp),
                  _buildHighlightedText(
                    place.subLabel,
                    searchQuery,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600]!,
                  ),
                  SizedBox(height: 4.sp),
                  CommonText.textBoldWeight400(
                    text:
                    "${place.latitude.toStringAsFixed(4)}, ${place.longitude.toStringAsFixed(4)}",
                    fontSize: 10.sp,
                    color: Colors.grey[500]!,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
      String text,
      String query, {
        required double fontSize,
        required FontWeight fontWeight,
        required Color color,
      }) {
    if (query.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (!lowerText.contains(lowerQuery)) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      );
    }

    final startIndex = lowerText.indexOf(lowerQuery);
    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        children: [
          if (startIndex > 0)
            TextSpan(
              text: text.substring(0, startIndex),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              backgroundColor: Colors.yellow[200],
            ),
          ),
          if (endIndex < text.length)
            TextSpan(
              text: text.substring(endIndex),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
        ],
      ),
    );
  }
}