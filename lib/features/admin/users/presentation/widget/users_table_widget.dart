import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/user_data_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersTableWidget extends ConsumerStatefulWidget {
  final List<UserModel> users;
  const UsersTableWidget({super.key, required this.users});

  @override
  ConsumerState<UsersTableWidget> createState() => _UsersTableWidgetState();
}

class _UsersTableWidgetState extends ConsumerState<UsersTableWidget> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<UserModel> _users = [];

  @override
  void initState() {
    _users = widget.users;
    super.initState();
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      switch (columnIndex) {
        case 1: // Name
          _users.sort((a, b) {
            final nameA = '${a.firstName} ${a.lastName}';
            final nameB = '${b.firstName} ${b.lastName}';
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          });
          break;
        case 2: // Phone
          _users.sort((a, b) {
            return ascending
                ? a.phone.compareTo(b.phone)
                : b.phone.compareTo(a.phone);
          });
          break;
        case 3: // Status
          _users.sort((a, b) {
            return ascending
                ? a.status.compareTo(b.status)
                : b.status.compareTo(a.status);
          });
          break;
        case 4: // Wallet Balance
          _users.sort((a, b) {
            return ascending
                ? a.walletBalance.compareTo(b.walletBalance)
                : b.walletBalance.compareTo(a.walletBalance);
          });
          break;
        case 5: // Points
          _users.sort((a, b) {
            return ascending
                ? a.points.compareTo(b.points)
                : b.points.compareTo(a.points);
          });
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant UsersTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.users != oldWidget.users) {
      setState(() => _users = widget.users);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_users.isEmpty) {
      return const Center(child: Text('No users available'));
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
                    const DataColumn(label: SizedBox(width: 80)),
                    DataColumn(
                      label: const Text("Full Name"),
                      onSort: (columnIndex, ascending) => _onSort(1, ascending),
                    ),
                    DataColumn(
                      label: const Text("Phone"),
                      onSort: (columnIndex, ascending) => _onSort(2, ascending),
                    ),
                    const DataColumn(label: Text("Email")),
                    const DataColumn(label: Text("is Banned?")),
                    DataColumn(
                      label: const Text("Wallet Balance"),
                      onSort: (columnIndex, ascending) => _onSort(4, ascending),
                    ),
                    DataColumn(
                      label: const Text("Points"),
                      onSort: (columnIndex, ascending) => _onSort(5, ascending),
                    ),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(_users.length, (index) {
                    final user = _users[index];
                    return buildUserDataRow(context, user, ref);
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
