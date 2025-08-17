import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/route_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTripRouteFieldWidget extends StatelessWidget {
  final RouteItemModel item;
  final int index;
  final int totalIndexes;
  final bool isActive;
  final VoidCallback onTap;
  final Function(String) onChanged;
  final VoidCallback? onAddStop;
  final VoidCallback? onRemoveStop;
  final VoidCallback? onSwap;

  const AddTripRouteFieldWidget({
    super.key,
    required this.item,
    required this.index,
    required this.totalIndexes,
    required this.isActive,
    required this.onTap,
    required this.onChanged,
    this.onAddStop,
    this.onRemoveStop,
    this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    final isPickup = item.id == "pickup";
    final isDestination = item.id == "destination";
    final isStop = !isPickup && !isDestination;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(
          color: isActive ? Palette.mainColor : Colors.grey[300]!,
          width: isActive ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left indicator
          Container(
            width: 4.sp,
            height: 50.sp,
            decoration: BoxDecoration(
              color: isPickup
                  ? Colors.green
                  : isDestination
                      ? Colors.red
                      : Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sp),
                bottomLeft: Radius.circular(8.sp),
              ),
            ),
          ),

          // Text field
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: TextField(
                controller: item.controller,
                onTap: onTap,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: item.hint,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    isPickup
                        ? Icons.radio_button_checked
                        : isDestination
                            ? Icons.location_on
                            : Icons.location_pin,
                    color: isPickup
                        ? Colors.green
                        : isDestination
                            ? Colors.red
                            : Colors.orange,
                    size: 20.sp,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onAddStop != null) ...[
                IconButton(
                  onPressed: onAddStop,
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                  tooltip: "Add Stop",
                ),
              ],
              if (onRemoveStop != null) ...[
                IconButton(
                  onPressed: onRemoveStop,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red[400],
                    size: 20.sp,
                  ),
                  tooltip: "Remove Stop",
                ),
              ],
              if (onSwap != null) ...[
                IconButton(
                  onPressed: onSwap,
                  icon: Icon(
                    Icons.swap_vert,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                  tooltip: "Swap Pickup and Destination",
                ),
              ],
              SizedBox(width: 8.sp),
            ],
          ),
        ],
      ),
    );
  }
}
