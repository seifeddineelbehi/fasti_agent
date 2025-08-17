import 'package:fasti_dashboard/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:fasti_dashboard/my_app.dart';
import 'package:fasti_dashboard/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScaffoldWithNavigation extends ConsumerWidget {
  const ScaffoldWithNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakpoint = ResponsiveBreakpoints.of(context).breakpoint;
    return switch (breakpoint.name) {
      MOBILE || TABLET => _ScaffoldWithDrawer(navigationShell),
      (_) => _ScaffoldWithNavigationRail(navigationShell),
    };
  }
}

class _ScaffoldWithNavigationRail extends ConsumerWidget {
  const _ScaffoldWithNavigationRail(this.navigationShell);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: const NavigationAppBar(),
      body: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: _NavigationRail(
                  navigationShell: navigationShell,
                  expand: true,
                ),
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: colorScheme.primary.withOpacity(0.2),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _ScaffoldWithDrawer extends ConsumerWidget {
  const _ScaffoldWithDrawer(this.navigationShell);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const NavigationAppBar(),
      body: navigationShell,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(border: Border()),
              margin: EdgeInsets.zero,
              child: Center(
                child: Text(
                  MyApp.title,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _NavigationRail(
                navigationShell: navigationShell,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationRail extends ConsumerWidget {
  const _NavigationRail({required this.navigationShell, required this.expand});

  final StatefulNavigationShell navigationShell;
  final bool expand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);

    // Get visible navigation items based on user permissions
    final visibleItems = NavigationItem.getVisibleItems(
      authState.currentUserPermissions,
    );

    // Create a mapping from all items to visible items for index management
    final Map<NavigationItem, int> itemToVisibleIndex = {};
    for (int i = 0; i < visibleItems.length; i++) {
      itemToVisibleIndex[visibleItems[i]] = i;
    }

    // Find the current selected index in visible items
    int? selectedIndex;
    if (navigationShell.currentIndex < NavigationItem.values.length) {
      final currentItem = NavigationItem.values[navigationShell.currentIndex];
      selectedIndex = itemToVisibleIndex[currentItem];
    }

    return NavigationRail(
      extended: expand,
      selectedIndex: selectedIndex,
      unselectedLabelTextStyle: theme.textTheme.bodyMedium,
      selectedLabelTextStyle: theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      onDestinationSelected: (index) {
        if (index < visibleItems.length) {
          final selectedItem = visibleItems[index];
          final originalIndex = NavigationItem.values.indexOf(selectedItem);

          navigationShell.goBranch(
            originalIndex,
            initialLocation: true,
          );
        }
      },
      destinations: [
        for (final item in visibleItems)
          NavigationRailDestination(
            icon: Icon(item.iconData),
            label: Text(item.label),
          ),
      ],
    );
  }
}
