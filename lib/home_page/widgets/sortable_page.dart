import '../data/medicines.dart';
import '../models/medicine.dart';
import 'package:flutter/material.dart';
import '../widgets/scrollable_widget.dart';

class SortablePage extends StatefulWidget {
  @override
  _SortablePageState createState() => _SortablePageState();
}

class _SortablePageState extends State<SortablePage> {
  late List<Medicine> medicines;
  int? sortColumnIndex;
  bool isAscending = false;



  @override
  void initState() {
    super.initState();

    medicines = allMedicines.cast<Medicine>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ScrollableWidget(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['Medicine Name', 'Stock'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(medicines),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Medicine> medicines) => medicines.map((Medicine medicine) {
        final cells = [medicine.medicineName, medicine.stock];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      var medicine1;
      var medicine2;
      medicines.sort((medecine1, medecine2) =>
          compareString(ascending, medicine1.medicineName, medicine2.medicineName));
    }else if (columnIndex == 1) {
      medicines.sort((medicine1, medicine2) =>
          compareString(ascending, '${medicine1.stock}', '${medicine2.stock}'));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}