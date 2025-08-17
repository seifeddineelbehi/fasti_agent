// widgets/agents_filter_widget.dart
import 'package:flutter/material.dart';

class AgentsFilterWidget extends StatelessWidget {
  final TextEditingController searchController;
  final String roleFilter;
  final Function(String) onRoleFilterChanged;
  final VoidCallback onClearFilters;
  final bool hasActiveFilters;

  const AgentsFilterWidget({
    super.key,
    required this.searchController,
    required this.roleFilter,
    required this.onRoleFilterChanged,
    required this.onClearFilters,
    required this.hasActiveFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter Row
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search agents by name or email...',
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
                value: roleFilter,
                decoration: InputDecoration(
                  labelText: 'Filter by Role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'all', child: Text('All Roles')),
                  DropdownMenuItem(
                      value: 'super_admin', child: Text('Super Admin')),
                  DropdownMenuItem(
                      value: 'car_agent', child: Text('Car Agent')),
                  DropdownMenuItem(
                      value: 'trip_agent', child: Text('Trip Agent')),
                  DropdownMenuItem(
                      value: 'user_support_agent',
                      child: Text('User Support')),
                  DropdownMenuItem(
                      value: 'driver_manager',
                      child: Text('Driver Manager')),
                ],
                onChanged: (value) => onRoleFilterChanged(value ?? 'all'),
              ),
            ),
          ],
        ),
        
        // Clear filters button (shown when filters are active)
        if (hasActiveFilters) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onClearFilters,
              icon: const Icon(Icons.clear),
              label: const Text('Clear Filters'),
            ),
          ),
        ],
      ],
    );
  }
}