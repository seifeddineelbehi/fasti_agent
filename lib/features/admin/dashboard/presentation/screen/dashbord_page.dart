import 'package:fasti_dashboard/features/admin/dashboard/presentation/riverpod/dashboard_provider.dart';
import 'package:fasti_dashboard/features/admin/dashboard/presentation/riverpod/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../widgets/widgets.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardNotifierProvider.notifier).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final responsive = ResponsiveBreakpoints.of(context);

    return ContentView(
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardNotifierProvider.notifier).refreshDashboardData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(
                title: 'Dashboard',
                description:
                    'Real-time analytics and insights for your business.',
              ),
              const Gap(24),
              if (dashboardState.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (dashboardState.failure != null)
                _buildErrorWidget(dashboardState.failure!)
              else if (dashboardState.analytics != null)
                _buildDashboardContent(dashboardState.analytics!, responsive)
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(dynamic failure) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
            const Gap(16),
            Text(
              'Failed to load dashboard data',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            Text(
              failure.toString(),
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(dashboardNotifierProvider.notifier)
                    .loadDashboardData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
      DashboardAnalytics analytics, ResponsiveBreakpointsData responsive) {
    return Column(
      children: [
        // KPI Cards
        _buildKPICards(analytics, responsive),
        const Gap(24),

        // Charts Section
        if (responsive.isMobile) ...[
          _buildRevenueChart(analytics),
          const Gap(16),
          _buildUserDistributionChart(analytics),
          const Gap(16),
          _buildCarTypesChart(analytics),
          const Gap(16),
          _buildTripStatusChart(analytics),
          const Gap(16),
          _buildDailyActivityChart(analytics),
          const Gap(16),
          _buildTransactionChart(analytics),
        ] else ...[
          Row(
            children: [
              Expanded(flex: 2, child: _buildRevenueChart(analytics)),
              const Gap(16),
              Expanded(child: _buildUserDistributionChart(analytics)),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(child: _buildCarTypesChart(analytics)),
              const Gap(16),
              Expanded(child: _buildTripStatusChart(analytics)),
              const Gap(16),
              Expanded(child: _buildTransactionChart(analytics)),
            ],
          ),
          const Gap(16),
          _buildDailyActivityChart(analytics),
        ],
      ],
    );
  }

  Widget _buildKPICards(
      DashboardAnalytics analytics, ResponsiveBreakpointsData responsive) {
    final kpiCards = [
      _KPICard(
        title: 'Total Revenue',
        value: '${analytics.totalRevenue.toStringAsFixed(0)}',
        icon: Icons.attach_money,
        color: Colors.green,
        subtitle: 'From trips & rentals',
      ),
      _KPICard(
        title: 'Total Users',
        value: '${analytics.totalUsers}',
        icon: Icons.people,
        color: Colors.blue,
        subtitle: '${analytics.activeDrivers} active drivers',
      ),
      _KPICard(
        title: 'Completed Trips',
        value: '${analytics.completedTrips}',
        icon: Icons.check_circle,
        color: Colors.orange,
        subtitle: 'Out of ${analytics.totalTrips} total',
      ),
      _KPICard(
        title: 'Available Cars',
        value: '${analytics.availableCars}',
        icon: Icons.directions_car,
        color: Colors.purple,
        subtitle: 'Out of ${analytics.totalCars} total',
      ),
    ];

    if (responsive.isMobile) {
      return Column(
        children: kpiCards
            .map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: card,
                ))
            .toList(),
      );
    } else {
      return Row(
        children: kpiCards
            .map<Widget>((card) => Expanded(child: card))
            .intersperse(const Gap(16))
            .toList(),
      );
    }
  }

  Widget _buildRevenueChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Monthly Revenue',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          const Gap(16),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                numberFormat:
                    NumberFormat.currency(symbol: 'MRU', decimalDigits: 0),
              ),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<MonthlyRevenue, String>(
                  name: 'Trip Revenue',
                  dataSource: analytics.monthlyRevenue,
                  xValueMapper: (MonthlyRevenue data, _) => data.month,
                  yValueMapper: (MonthlyRevenue data, _) => data.tripRevenue,
                  color: Colors.blue,
                ),
                ColumnSeries<MonthlyRevenue, String>(
                  name: 'Rental Revenue',
                  dataSource: analytics.monthlyRevenue,
                  xValueMapper: (MonthlyRevenue data, _) => data.month,
                  yValueMapper: (MonthlyRevenue data, _) => data.rentalRevenue,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildUserDistributionChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Distribution',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(16),
            SizedBox(
              height: 250,
              child: SfCircularChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  DoughnutSeries<UserTypeDistribution, String>(
                    dataSource: analytics.userDistribution,
                    xValueMapper: (UserTypeDistribution data, _) =>
                        data.userType,
                    yValueMapper: (UserTypeDistribution data, _) => data.count,
                    dataLabelMapper: (UserTypeDistribution data, _) =>
                        '${data.percentage.toStringAsFixed(1)}%',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    explode: true,
                    explodeIndex: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarTypesChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car Types',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(16),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  BarSeries<CarTypeDistribution, String>(
                    dataSource: analytics.carTypeDistribution,
                    xValueMapper: (CarTypeDistribution data, _) => data.carType,
                    yValueMapper: (CarTypeDistribution data, _) => data.count,
                    color: Colors.teal,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripStatusChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Status',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(16),
            SizedBox(
              height: 250,
              child: SfCircularChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  PieSeries<TripStatusData, String>(
                    dataSource: analytics.tripStatusData,
                    xValueMapper: (TripStatusData data, _) => data.status,
                    yValueMapper: (TripStatusData data, _) => data.count,
                    dataLabelMapper: (TripStatusData data, _) =>
                        '${data.percentage.toStringAsFixed(1)}%',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyActivityChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Activity (Last 7 Days)',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(16),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  LineSeries<DailyActivityData, String>(
                    name: 'Trips',
                    dataSource: analytics.dailyActivity,
                    xValueMapper: (DailyActivityData data, _) => data.date,
                    yValueMapper: (DailyActivityData data, _) => data.trips,
                    color: Colors.blue,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<DailyActivityData, String>(
                    name: 'Rentals',
                    dataSource: analytics.dailyActivity,
                    xValueMapper: (DailyActivityData data, _) => data.date,
                    yValueMapper: (DailyActivityData data, _) => data.rentals,
                    color: Colors.orange,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionChart(DashboardAnalytics analytics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transactions',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(16),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  numberFormat:
                      NumberFormat.currency(symbol: 'MRU', decimalDigits: 0),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<TransactionTypeData, String>(
                    dataSource: analytics.transactionTypeData,
                    xValueMapper: (TransactionTypeData data, _) => data.type,
                    yValueMapper: (TransactionTypeData data, _) => data.amount,
                    color: Colors.purple,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KPICard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String subtitle;

  const _KPICard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.trending_up, color: color, size: 16),
                ),
              ],
            ),
            const Gap(16),
            Text(
              value,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Gap(4),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const Gap(4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
