import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:flutter/material.dart';

enum NavigationItem {
  dashboard(
    iconData: Icons.dashboard_outlined,
    requiredPermissions: [AgentPermissions.viewDashboard], // Only for marketing
  ),
  users(
    iconData: Icons.people_outline,
    requiredPermissions: [AgentPermissions.viewUsers],
  ),
  drivers(
    iconData: Icons.drive_eta_outlined,
    requiredPermissions: [AgentPermissions.viewDrivers],
  ),
  trips(
    iconData: Icons.map_outlined,
    requiredPermissions: [AgentPermissions.viewTrips],
  ),
  cars(
    iconData: Icons.directions_car_outlined,
    requiredPermissions: [AgentPermissions.viewCars],
  ),
  rent_requests(
    iconData: Icons.assignment_outlined,
    requiredPermissions: [AgentPermissions.viewRentals],
  ),
  agents(
    iconData: Icons.support_agent,
    requiredPermissions: [AgentPermissions.viewAgents],
  );
  // Removed settings completely

  const NavigationItem({
    required this.iconData,
    required this.requiredPermissions,
  });

  final IconData iconData;
  final List<String> requiredPermissions;

  String get label => switch (this) {
        NavigationItem.dashboard => 'Dashboard',
        NavigationItem.users => 'Users',
        NavigationItem.drivers => 'Drivers',
        NavigationItem.trips => 'Trips',
        NavigationItem.cars => 'Cars',
        NavigationItem.rent_requests => 'Rental Requests',
        NavigationItem.agents => 'Agents',
      };

  /// Check if this navigation item should be visible based on agent permissions
  bool isVisibleForPermissions(List<String> agentPermissions) {
    // All navigation items now require specific permissions
    if (requiredPermissions.isEmpty) return true;

    // Check if agent has at least one of the required permissions
    return requiredPermissions
        .any((permission) => agentPermissions.contains(permission));
  }

  /// Get filtered navigation items based on agent permissions
  static List<NavigationItem> getVisibleItems(List<String> agentPermissions) {
    return NavigationItem.values
        .where((item) => item.isVisibleForPermissions(agentPermissions))
        .toList();
  }

  /// Get the first accessible route for an agent based on their permissions
  static String getFirstAccessibleRoute(List<String> agentPermissions) {
    final visibleItems = getVisibleItems(agentPermissions);

    if (visibleItems.isEmpty) {
      // If no permissions, redirect to login
      return '/login';
    }

    // Priority order: Dashboard -> Cars -> Users -> Drivers -> Trips -> Rentals -> Agents -> Add Drivers
    final priorityOrder = [
      NavigationItem.dashboard,
      NavigationItem.cars,
      NavigationItem.users,
      NavigationItem.drivers,
      NavigationItem.trips,
      NavigationItem.rent_requests,
      NavigationItem.agents,
    ];

    // Find the first item in priority order that the agent has access to
    for (final item in priorityOrder) {
      if (visibleItems.contains(item)) {
        return item.routePath;
      }
    }

    // Fallback to first available item
    return visibleItems.first.routePath;
  }

  /// Get route path for navigation item
  String get routePath => switch (this) {
        NavigationItem.dashboard => '/dashboard',
        NavigationItem.users => '/users',
        NavigationItem.drivers => '/drivers',
        NavigationItem.trips => '/trips',
        NavigationItem.cars => '/cars',
        NavigationItem.rent_requests => '/rents_requests',
        NavigationItem.agents => '/agents',
      };

  /// Get navigation item from route path
  static NavigationItem? fromRoutePath(String path) {
    for (final item in NavigationItem.values) {
      if (path.startsWith(item.routePath)) {
        return item;
      }
    }
    return null;
  }
}
