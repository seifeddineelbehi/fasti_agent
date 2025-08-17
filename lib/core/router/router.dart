import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart'; // Import for permissions
import 'package:fasti_dashboard/features/admin/agents/presentation/screen/agent_page.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/screen/agents_page.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/screen/create_agent_page.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/screen/car_page.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/screen/cars_page.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/screen/create_car_page.dart';
import 'package:fasti_dashboard/features/admin/dashboard/presentation/screen/dashbord_page.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/riverpod/drivers_provider.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/screen/driver_page.dart';
import 'package:fasti_dashboard/features/admin/drivers/presentation/screen/drivers_page.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/screen/rent_page.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/screen/rents_page.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/screen/add_saved_places_page.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/screen/add_trip_page.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/screen/saved_places_page.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/screen/trip_page.dart';
import 'package:fasti_dashboard/features/admin/trips/presentation/screen/trips_page.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/screen/user_page.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/screen/users_page.dart';
import 'package:fasti_dashboard/features/auth/data/data_source/auth_cached_data_source.dart';
import 'package:fasti_dashboard/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:fasti_dashboard/features/auth/presentation/screen/login_page.dart';
import 'package:fasti_dashboard/splash_screen_view.dart';
import 'package:fasti_dashboard/widgets/navigation/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'router.g.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/login';
  static const String dashboardPage = '/dashboard';
  static const String usersPage = '/users';
  static const String driversPage = '/drivers';
  static const String tripsPage = '/trips';
  static const String addTripPage = '/admin/trips/add';
  static const String cars = '/cars';
  static const String createCars = '/admin/cars/create';
  static const String createAgents = '/admin/agents/create';
  static const String rentsRequests = '/rents_requests';
  static const String agents = '/agents';
  static const String settings = '/settings';
  static const String addDriver = '/addDriver';
  static const String savedPlacesPage = '/saved-places';
  static const String addSavedPlacePage = '/saved-places/add';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) async {
      final bool isLoggedIn =
          await AuthCachedDataSource.isAgentLoggedInStatic();

      // Load agent data if logged in
      if (isLoggedIn) {
        await ref.read(authNotifierProvider.notifier).getAgentCached();
        await ref.read(driversNotifierProvider.notifier).fetchAdminData();
      }

      final String location = state.matchedLocation;

      // Public routes that don't require authentication
      const publicRoutes = ['/login'];

      // Check if current route is public
      final bool isPublicRoute = publicRoutes.contains(location);

      // If user is not logged in and trying to access protected route
      if (!isLoggedIn && !isPublicRoute) {
        return '/login';
      }

      // If user is logged in and trying to access login page, redirect based on permissions
      if (isLoggedIn && location == '/login') {
        final authState = ref.read(authNotifierProvider);
        final userPermissions = authState.currentUserPermissions;

        // Determine redirect route based on agent permissions
        final redirectRoute = _getFirstAccessibleRoute(userPermissions);

        // If agent has no permissions, sign them out
        if (redirectRoute == '/login') {
          await ref.read(authNotifierProvider.notifier).signOut();
          return '/login';
        }

        return redirectRoute;
      }

      // Permission-based route checking for logged-in agents
      if (isLoggedIn) {
        final authState = ref.read(authNotifierProvider);
        final userPermissions = authState.currentUserPermissions;

        // Check if agent has permission to access specific routes
        final routePermissions = _getRoutePermissions(location);
        if (routePermissions.isNotEmpty) {
          final hasPermission = routePermissions
              .any((permission) => userPermissions.contains(permission));

          if (!hasPermission) {
            // Redirect to first accessible page if no permission
            final firstAccessibleRoute =
                _getFirstAccessibleRoute(userPermissions);

            // If agent has no permissions, sign them out
            if (firstAccessibleRoute == '/login') {
              await ref.read(authNotifierProvider.notifier).signOut();
              return '/login';
            }

            return firstAccessibleRoute;
          }
        }
      }

      // No redirect needed
      return null;
    },
    // Handle redirect errors
    onException: (context, state, router) {
      if (kDebugMode) {
        print('Router exception: ${state.error}');
      }
      router.go('/login');
    },
  );
});

// Helper function to get first accessible route based on permissions
String _getFirstAccessibleRoute(List<String> agentPermissions) {
  // Priority order: Dashboard -> Cars -> Users -> Drivers -> Trips -> Rentals -> Agents
  final priorityRoutes = [
    {
      'route': '/dashboard',
      'permissions': [AgentPermissions.viewDashboard]
    },
    {
      'route': '/cars',
      'permissions': [AgentPermissions.viewCars]
    },
    {
      'route': '/users',
      'permissions': [AgentPermissions.viewUsers]
    },
    {
      'route': '/drivers',
      'permissions': [AgentPermissions.viewDrivers]
    },
    {
      'route': '/trips',
      'permissions': [AgentPermissions.viewTrips]
    },
    {
      'route': '/rents_requests',
      'permissions': [AgentPermissions.viewRentals]
    },
    {
      'route': '/agents',
      'permissions': [AgentPermissions.viewAgents]
    },
  ];

  // Find the first route the agent has permission to access
  for (final routeData in priorityRoutes) {
    final routePermissions = routeData['permissions'] as List<String>;
    final hasPermission = routePermissions
        .any((permission) => agentPermissions.contains(permission));

    if (hasPermission) {
      return routeData['route'] as String;
    }
  }

  // If no permissions found, return login (will trigger signout)
  return '/login';
}

// Helper function to get required permissions for routes
List<String> _getRoutePermissions(String route) {
  final routePermissions = <String, List<String>>{
    '/dashboard': [AgentPermissions.viewDashboard],
    '/users': [AgentPermissions.viewUsers],
    '/drivers': [AgentPermissions.viewDrivers],
    '/trips': [AgentPermissions.viewTrips],
    '/cars': [AgentPermissions.viewCars],
    '/rents_requests': [AgentPermissions.viewRentals],
    '/agents': [AgentPermissions.viewAgents],
    '/addDriver': [
      AgentPermissions.viewDrivers,
      AgentPermissions.approveDrivers
    ],
    '/admin/cars/create': [AgentPermissions.addCars],
    '/admin/agents/create': [AgentPermissions.createAgents],
    '/admin/trips/add': [AgentPermissions.viewTrips],
    '/saved-places': [AgentPermissions.viewTrips],
    '/saved-places/add': [AgentPermissions.viewTrips],
  };

  for (final entry in routePermissions.entries) {
    if (route.startsWith(entry.key)) {
      return entry.value;
    }
  }

  return [];
}

@TypedStatefulShellRoute<ShellRouteData>(
  branches: [
    TypedStatefulShellBranch(
        routes: [TypedGoRoute<DashboardRoute>(path: AppRoutes.dashboardPage)]),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<UsersPageRoute>(
          path: AppRoutes.usersPage,
          routes: [TypedGoRoute<UserPageRoute>(path: ':userId')],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DriversPageRoute>(
          path: AppRoutes.driversPage,
          routes: [TypedGoRoute<DriverPageRoute>(path: ':driverId')],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<TripsPageRoute>(
          path: AppRoutes.tripsPage,
          routes: [TypedGoRoute<TripPageRoute>(path: ':tripId')],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<CarsPageRoute>(
          path: AppRoutes.cars,
          routes: [
            TypedGoRoute<CarPageRoute>(path: ':carId'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<RentsPageRoute>(
          path: AppRoutes.rentsRequests,
          routes: [TypedGoRoute<RentPageRoute>(path: ':rentId')],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<AgentsPageRoute>(
          path: AppRoutes.agents,
          routes: [TypedGoRoute<AgentPageRoute>(path: ':agentId')],
        ),
      ],
    ),
  ],
)
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return SelectionArea(
      child: ScaffoldWithNavigation(navigationShell: navigationShell),
    );
  }
}

@TypedGoRoute<SplashRoute>(path: AppRoutes.splashScreen)
class SplashRoute extends GoRouteData with _$SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Loading',
      color: Theme.of(context).primaryColor,
      child: const SplashScreen(),
    );
  }
}

// Login Screen Route (outside of shell)
@TypedGoRoute<LoginRoute>(path: AppRoutes.loginPage)
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Login',
      color: Theme.of(context).primaryColor,
      child: const LoginPage(),
    );
  }
}

class DashboardRoute extends GoRouteData with _$DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Overview',
      color: Theme.of(context).primaryColor,
      child: const DashboardPage(),
    );
  }
}

@TypedGoRoute<AddTripPageRoute>(path: AppRoutes.addTripPage)
class AddTripPageRoute extends GoRouteData with _$AddTripPageRoute {
  const AddTripPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Add Trip',
      color: Theme.of(context).primaryColor,
      child: const AddTripPage(),
    );
  }
}

class UsersPageRoute extends GoRouteData with _$UsersPageRoute {
  const UsersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Users',
      color: Theme.of(context).primaryColor,
      child: const UsersPage(),
    );
  }
}

class UserPageRoute extends GoRouteData with _$UserPageRoute {
  const UserPageRoute({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - User Details',
      color: Theme.of(context).primaryColor,
      child: UserPage(
        userId: userId,
      ),
    );
  }
}

class DriversPageRoute extends GoRouteData with _$DriversPageRoute {
  const DriversPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Drivers',
      color: Theme.of(context).primaryColor,
      child: const DriversPage(),
    );
  }
}

class DriverPageRoute extends GoRouteData with _$DriverPageRoute {
  const DriverPageRoute({required this.driverId});

  final String driverId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Driver Details',
      color: Theme.of(context).primaryColor,
      child: DriverPage(
        driverId: driverId,
      ),
    );
  }
}

class TripsPageRoute extends GoRouteData with _$TripsPageRoute {
  const TripsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Trips',
      color: Theme.of(context).primaryColor,
      child: const TripsPage(),
    );
  }
}

class TripPageRoute extends GoRouteData with _$TripPageRoute {
  const TripPageRoute({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Trip Details',
      color: Theme.of(context).primaryColor,
      child: TripPage(
        tripId: tripId,
      ),
    );
  }
}

class CarsPageRoute extends GoRouteData with _$CarsPageRoute {
  const CarsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Cars',
      color: Theme.of(context).primaryColor,
      child: const CarsPage(),
    );
  }
}

class CarPageRoute extends GoRouteData with _$CarPageRoute {
  const CarPageRoute({required this.carId});

  final String carId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Car Details',
      color: Theme.of(context).primaryColor,
      child: CarPage(
        carId: carId,
      ),
    );
  }
}

@TypedGoRoute<CreateCarPageRoute>(path: AppRoutes.createCars)
class CreateCarPageRoute extends GoRouteData with _$CreateCarPageRoute {
  const CreateCarPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Create Car',
      color: Theme.of(context).primaryColor,
      child: CreateCarPage(),
    );
  }
}

@TypedGoRoute<CreateAgentPageRoute>(path: AppRoutes.createAgents)
class CreateAgentPageRoute extends GoRouteData with _$CreateAgentPageRoute {
  const CreateAgentPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Create Agent',
      color: Theme.of(context).primaryColor,
      child: CreateAgentPage(),
    );
  }
}

class RentsPageRoute extends GoRouteData with _$RentsPageRoute {
  const RentsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Rent Requests',
      color: Theme.of(context).primaryColor,
      child: const RentsPage(),
    );
  }
}

class RentPageRoute extends GoRouteData with _$RentPageRoute {
  const RentPageRoute({required this.rentId});

  final String rentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Rent Details',
      color: Theme.of(context).primaryColor,
      child: RentPage(
        rentId: rentId,
      ),
    );
  }
}

class AgentsPageRoute extends GoRouteData with _$AgentsPageRoute {
  const AgentsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Agents',
      color: Theme.of(context).primaryColor,
      child: const AgentsPage(),
    );
  }
}

class AgentPageRoute extends GoRouteData with _$AgentPageRoute {
  const AgentPageRoute({required this.agentId});

  final String agentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Agent Details',
      color: Theme.of(context).primaryColor,
      child: AgentPage(
        agentId: agentId,
      ),
    );
  }
}

@TypedGoRoute<SavedPlacesPageRoute>(path: AppRoutes.savedPlacesPage)
class SavedPlacesPageRoute extends GoRouteData with _$SavedPlacesPageRoute {
  const SavedPlacesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Saved Places',
      color: Theme.of(context).primaryColor,
      child: const SavedPlacesPage(),
    );
  }
}

@TypedGoRoute<AddSavedPlacePageRoute>(path: AppRoutes.addSavedPlacePage)
class AddSavedPlacePageRoute extends GoRouteData with _$AddSavedPlacePageRoute {
  const AddSavedPlacePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Title(
      title: 'Fasti Dashboard - Add Saved Place',
      color: Theme.of(context).primaryColor,
      child: const AddSavedPlacePage(),
    );
  }
}
