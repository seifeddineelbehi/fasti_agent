import 'package:fasti_dashboard/features/admin/drivers/presentation/widget/driver_data_row.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriversTableWidget extends ConsumerStatefulWidget {
  final List<UserModel> drivers;
  const DriversTableWidget({super.key, required this.drivers});

  @override
  ConsumerState<DriversTableWidget> createState() => _DriversTableWidgetState();
}

class _DriversTableWidgetState extends ConsumerState<DriversTableWidget> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<UserModel> _drivers = [];

  @override
  void initState() {
    _drivers = widget.drivers;
    super.initState();
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _drivers.sort((a, b) {
        final statusA = a.driverInfo?.approvedStatus ?? '';
        final statusB = b.driverInfo?.approvedStatus ?? '';
        return ascending
            ? statusA.compareTo(statusB)
            : statusB.compareTo(statusA);
      });
    });
  }

  @override
  void didUpdateWidget(covariant DriversTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.drivers != oldWidget.drivers) {
      setState(() => _drivers = widget.drivers);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_drivers.isEmpty) {
      return const Center(child: Text('No drivers available'));
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
                  columns: const [
                    DataColumn(label: SizedBox(width: 80)),
                    DataColumn(label: Text("Full Name")),
                    DataColumn(label: Text("Phone")),
                    DataColumn(label: Text("Approved Status")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("is Banned?")),
                    DataColumn(label: Text("Wallet Balance")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(_drivers.length, (index) {
                    final driver = _drivers[index];
                    return buildDriverDataRow(context, driver, ref);
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
