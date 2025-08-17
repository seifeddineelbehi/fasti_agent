import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/cars/presentation/widget/car_data_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarsTableWidget extends ConsumerStatefulWidget {
  final List<CarModel> cars;
  const CarsTableWidget({super.key, required this.cars});

  @override
  ConsumerState<CarsTableWidget> createState() => _CarsTableWidgetState();
}

class _CarsTableWidgetState extends ConsumerState<CarsTableWidget> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<CarModel> _cars = [];

  @override
  void initState() {
    _cars = widget.cars;
    super.initState();
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      switch (columnIndex) {
        case 1: // Brand & Model
          _cars.sort((a, b) {
            final nameA = '${a.brand} ${a.model}';
            final nameB = '${b.brand} ${b.model}';
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          });
          break;
        case 2: // Type
          _cars.sort((a, b) {
            return ascending
                ? a.type.compareTo(b.type)
                : b.type.compareTo(a.type);
          });
          break;
        case 3: // Seats
          _cars.sort((a, b) {
            return ascending
                ? a.seats.compareTo(b.seats)
                : b.seats.compareTo(a.seats);
          });
          break;
        case 4: // Price
          _cars.sort((a, b) {
            return ascending
                ? a.pricePerDay.compareTo(b.pricePerDay)
                : b.pricePerDay.compareTo(a.pricePerDay);
          });
          break;
        case 5: // Availability
          _cars.sort((a, b) {
            return ascending
                ? a.isAvailable.toString().compareTo(b.isAvailable.toString())
                : b.isAvailable.toString().compareTo(a.isAvailable.toString());
          });
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant CarsTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cars != oldWidget.cars) {
      setState(() => _cars = widget.cars);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cars.isEmpty) {
      return const Center(child: Text('No cars available'));
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
                    const DataColumn(
                        label: SizedBox(width: 80, child: Text("Image"))),
                    DataColumn(
                      label: const Text("Brand & Model"),
                      onSort: (columnIndex, ascending) => _onSort(1, ascending),
                    ),
                    DataColumn(
                      label: const Text("Type"),
                      onSort: (columnIndex, ascending) => _onSort(2, ascending),
                    ),
                    DataColumn(
                      label: const Text("Seats"),
                      onSort: (columnIndex, ascending) => _onSort(3, ascending),
                    ),
                    DataColumn(
                      label: const Text("Price/Day"),
                      onSort: (columnIndex, ascending) => _onSort(4, ascending),
                    ),
                    DataColumn(
                      label: const Text("Availability"),
                      onSort: (columnIndex, ascending) => _onSort(5, ascending),
                    ),
                    const DataColumn(label: Text("Active Rentals")),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(_cars.length, (index) {
                    final car = _cars[index];
                    return buildCarDataRow(context, car, ref);
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
