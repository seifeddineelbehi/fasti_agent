// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $shellRouteData,
      $splashRoute,
      $loginRoute,
      $addTripPageRoute,
      $createCarPageRoute,
      $createAgentPageRoute,
      $savedPlacesPageRoute,
      $addSavedPlacePageRoute,
    ];

RouteBase get $shellRouteData => StatefulShellRouteData.$route(
      factory: $ShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/dashboard',
              factory: _$DashboardRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/users',
              factory: _$UsersPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':userId',
                  factory: _$UserPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/drivers',
              factory: _$DriversPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':driverId',
                  factory: _$DriverPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/trips',
              factory: _$TripsPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':tripId',
                  factory: _$TripPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/cars',
              factory: _$CarsPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':carId',
                  factory: _$CarPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/rents_requests',
              factory: _$RentsPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':rentId',
                  factory: _$RentPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/agents',
              factory: _$AgentsPageRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':agentId',
                  factory: _$AgentPageRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $ShellRouteDataExtension on ShellRouteData {
  static ShellRouteData _fromState(GoRouterState state) =>
      const ShellRouteData();
}

mixin _$DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashboard',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$UsersPageRoute on GoRouteData {
  static UsersPageRoute _fromState(GoRouterState state) =>
      const UsersPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/users',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$UserPageRoute on GoRouteData {
  static UserPageRoute _fromState(GoRouterState state) => UserPageRoute(
        userId: state.pathParameters['userId']!,
      );

  UserPageRoute get _self => this as UserPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/users/${Uri.encodeComponent(_self.userId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DriversPageRoute on GoRouteData {
  static DriversPageRoute _fromState(GoRouterState state) =>
      const DriversPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/drivers',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DriverPageRoute on GoRouteData {
  static DriverPageRoute _fromState(GoRouterState state) => DriverPageRoute(
        driverId: state.pathParameters['driverId']!,
      );

  DriverPageRoute get _self => this as DriverPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/drivers/${Uri.encodeComponent(_self.driverId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TripsPageRoute on GoRouteData {
  static TripsPageRoute _fromState(GoRouterState state) =>
      const TripsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/trips',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TripPageRoute on GoRouteData {
  static TripPageRoute _fromState(GoRouterState state) => TripPageRoute(
        tripId: state.pathParameters['tripId']!,
      );

  TripPageRoute get _self => this as TripPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/trips/${Uri.encodeComponent(_self.tripId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$CarsPageRoute on GoRouteData {
  static CarsPageRoute _fromState(GoRouterState state) => const CarsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/cars',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$CarPageRoute on GoRouteData {
  static CarPageRoute _fromState(GoRouterState state) => CarPageRoute(
        carId: state.pathParameters['carId']!,
      );

  CarPageRoute get _self => this as CarPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/cars/${Uri.encodeComponent(_self.carId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$RentsPageRoute on GoRouteData {
  static RentsPageRoute _fromState(GoRouterState state) =>
      const RentsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/rents_requests',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$RentPageRoute on GoRouteData {
  static RentPageRoute _fromState(GoRouterState state) => RentPageRoute(
        rentId: state.pathParameters['rentId']!,
      );

  RentPageRoute get _self => this as RentPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/rents_requests/${Uri.encodeComponent(_self.rentId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AgentsPageRoute on GoRouteData {
  static AgentsPageRoute _fromState(GoRouterState state) =>
      const AgentsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/agents',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AgentPageRoute on GoRouteData {
  static AgentPageRoute _fromState(GoRouterState state) => AgentPageRoute(
        agentId: state.pathParameters['agentId']!,
      );

  AgentPageRoute get _self => this as AgentPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/agents/${Uri.encodeComponent(_self.agentId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: _$SplashRoute._fromState,
    );

mixin _$SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: _$LoginRoute._fromState,
    );

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location(
        '/login',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addTripPageRoute => GoRouteData.$route(
      path: '/admin/trips/add',
      factory: _$AddTripPageRoute._fromState,
    );

mixin _$AddTripPageRoute on GoRouteData {
  static AddTripPageRoute _fromState(GoRouterState state) =>
      const AddTripPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/trips/add',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createCarPageRoute => GoRouteData.$route(
      path: '/admin/cars/create',
      factory: _$CreateCarPageRoute._fromState,
    );

mixin _$CreateCarPageRoute on GoRouteData {
  static CreateCarPageRoute _fromState(GoRouterState state) =>
      const CreateCarPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/cars/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createAgentPageRoute => GoRouteData.$route(
      path: '/admin/agents/create',
      factory: _$CreateAgentPageRoute._fromState,
    );

mixin _$CreateAgentPageRoute on GoRouteData {
  static CreateAgentPageRoute _fromState(GoRouterState state) =>
      const CreateAgentPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/agents/create',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $savedPlacesPageRoute => GoRouteData.$route(
      path: '/saved-places',
      factory: _$SavedPlacesPageRoute._fromState,
    );

mixin _$SavedPlacesPageRoute on GoRouteData {
  static SavedPlacesPageRoute _fromState(GoRouterState state) =>
      const SavedPlacesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/saved-places',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $addSavedPlacePageRoute => GoRouteData.$route(
      path: '/saved-places/add',
      factory: _$AddSavedPlacePageRoute._fromState,
    );

mixin _$AddSavedPlacePageRoute on GoRouteData {
  static AddSavedPlacePageRoute _fromState(GoRouterState state) =>
      const AddSavedPlacePageRoute();

  @override
  String get location => GoRouteData.$location(
        '/saved-places/add',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
