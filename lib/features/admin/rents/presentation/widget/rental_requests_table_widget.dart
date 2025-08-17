import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/widget/rental_request_data_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentalRequestsTableWidget extends ConsumerStatefulWidget {
  final List<RentalRequestModel> requests;

  const RentalRequestsTableWidget({
    super.key,
    required this.requests,
  });

  @override
  ConsumerState<RentalRequestsTableWidget> createState() =>
      _RentalRequestsTableWidgetState();
}

class _RentalRequestsTableWidgetState
    extends ConsumerState<RentalRequestsTableWidget> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<RentalRequestModel> _requests = [];

  @override
  void initState() {
    _requests = widget.requests;
    super.initState();
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      switch (columnIndex) {
        case 1: // Car Name
          _requests.sort((a, b) {
            final carA = '${a.car.brand} ${a.car.model}';
            final carB = '${b.car.brand} ${b.car.model}';
            return ascending ? carA.compareTo(carB) : carB.compareTo(carA);
          });
          break;
        case 2: // Customer Name
          _requests.sort((a, b) {
            final nameA = '${a.user.firstName} ${a.user.lastName}';
            final nameB = '${b.user.firstName} ${b.user.lastName}';
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          });
          break;
        case 3: // Start Date
          _requests.sort((a, b) {
            final dateA =
                DateTime.tryParse(a.reservationDateStart) ?? DateTime.now();
            final dateB =
                DateTime.tryParse(b.reservationDateStart) ?? DateTime.now();
            return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
          });
          break;
        case 4: // Duration
          _requests.sort((a, b) {
            return ascending
                ? a.numberOfDays.compareTo(b.numberOfDays)
                : b.numberOfDays.compareTo(a.numberOfDays);
          });
          break;
        case 6: // Total Cost
          _requests.sort((a, b) {
            return ascending
                ? a.totalCost.compareTo(b.totalCost)
                : b.totalCost.compareTo(a.totalCost);
          });
          break;
        case 7: // Status
          _requests.sort((a, b) {
            return ascending
                ? a.status.compareTo(b.status)
                : b.status.compareTo(a.status);
          });
          break;
        case 8: // Submitted Date
          _requests.sort((a, b) {
            final dateA = DateTime.tryParse(a.submittedAt) ?? DateTime.now();
            final dateB = DateTime.tryParse(b.submittedAt) ?? DateTime.now();
            return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
          });
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant RentalRequestsTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.requests != oldWidget.requests) {
      setState(() => _requests = widget.requests);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_requests.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_car_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No rental requests available',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
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
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  horizontalMargin: 12,
                  showBottomBorder: true,
                  showCheckboxColumn: false,
                  dividerThickness: 0.5,
                  columnSpacing: 20,
                  columns: [
                    const DataColumn(
                      label: SizedBox(width: 80, child: Text("Car Image")),
                    ),
                    DataColumn(
                      label: const Text("Car"),
                      onSort: (columnIndex, ascending) => _onSort(1, ascending),
                    ),
                    DataColumn(
                      label: const Text("Customer"),
                      onSort: (columnIndex, ascending) => _onSort(2, ascending),
                    ),
                    DataColumn(
                      label: const Text("Rental Period"),
                      onSort: (columnIndex, ascending) => _onSort(3, ascending),
                    ),
                    DataColumn(
                      label: const Text("Duration"),
                      onSort: (columnIndex, ascending) => _onSort(4, ascending),
                    ),
                    const DataColumn(label: Text("With Driver")),
                    DataColumn(
                      label: const Text("Total Cost"),
                      onSort: (columnIndex, ascending) => _onSort(6, ascending),
                    ),
                    DataColumn(
                      label: const Text("Status"),
                      onSort: (columnIndex, ascending) => _onSort(7, ascending),
                    ),
                    DataColumn(
                      label: const Text("Submitted"),
                      onSort: (columnIndex, ascending) => _onSort(8, ascending),
                    ),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(_requests.length, (index) {
                    final request = _requests[index];
                    return buildRentalRequestDataRow(context, request, ref);
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
