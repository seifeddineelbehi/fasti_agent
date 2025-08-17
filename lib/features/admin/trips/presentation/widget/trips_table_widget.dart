import 'package:fasti_dashboard/features/admin/trips/presentation/widget/trip_data_row.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripsTableWidget extends ConsumerStatefulWidget {
  final List<TripModel> trips;
  const TripsTableWidget({super.key, required this.trips});

  @override
  ConsumerState<TripsTableWidget> createState() => _TripsTableWidgetState();
}

class _TripsTableWidgetState extends ConsumerState<TripsTableWidget> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<TripModel> _trips = [];

  @override
  void initState() {
    _trips = widget.trips;
    super.initState();
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      switch (columnIndex) {
        case 0: // User Name
          _trips.sort((a, b) {
            final nameA = '${a.user.firstName} ${a.user.lastName}';
            final nameB = '${b.user.firstName} ${b.user.lastName}';
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          });
          break;
        case 1: // Driver Name
          _trips.sort((a, b) {
            final nameA = '${a.driver.firstName} ${a.driver.lastName}';
            final nameB = '${b.driver.firstName} ${b.driver.lastName}';
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          });
          break;
        case 4: // Status
          _trips.sort((a, b) {
            return ascending
                ? a.status.compareTo(b.status)
                : b.status.compareTo(a.status);
          });
          break;
        case 5: // Fare
          _trips.sort((a, b) {
            return ascending
                ? a.fare.compareTo(b.fare)
                : b.fare.compareTo(a.fare);
          });
          break;
        case 6: // Payment Method
          _trips.sort((a, b) {
            return ascending
                ? a.paymentMethod.compareTo(b.paymentMethod)
                : b.paymentMethod.compareTo(a.paymentMethod);
          });
          break;
        case 7: // Distance
          _trips.sort((a, b) {
            return ascending
                ? a.distance.compareTo(b.distance)
                : b.distance.compareTo(a.distance);
          });
          break;
        case 8: // Time
          _trips.sort((a, b) {
            return ascending
                ? a.time.compareTo(b.time)
                : b.time.compareTo(a.time);
          });
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant TripsTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trips != oldWidget.trips) {
      setState(() => _trips = widget.trips);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_trips.isEmpty) {
      return const Center(child: Text('No trips available'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final ScrollController horizontalController = ScrollController();
        final ScrollController verticalController = ScrollController();
        return Scrollbar(
          controller: horizontalController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: verticalController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: horizontalController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  dataRowHeight: 80,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                  headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  horizontalMargin: 12,
                  showBottomBorder: true,
                  showCheckboxColumn: false,
                  dividerThickness: 0.5,
                  columnSpacing: 20,
                  columns: [
                    DataColumn(
                      label: const Text("User"),
                      onSort: _onSort,
                    ),
                    DataColumn(
                      label: const Text("Driver"),
                      onSort: _onSort,
                    ),
                    const DataColumn(label: Text("Origin")),
                    const DataColumn(label: Text("Destination")),
                    DataColumn(
                      label: const Text("Status"),
                      onSort: _onSort,
                    ),
                    DataColumn(
                      label: const Text("Fare"),
                      onSort: _onSort,
                    ),
                    DataColumn(
                      label: const Text("Method"),
                      onSort: _onSort,
                    ),
                    DataColumn(
                      label: const Text("Distance"),
                      onSort: _onSort,
                    ),
                    DataColumn(
                      label: const Text("Time"),
                      onSort: _onSort,
                    ),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(_trips.length, (index) {
                    final trip = _trips[index];
                    return buildTripDataRow(context, trip, ref);
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
