// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datatable/detalle_datasource.dart';
import 'package:flutter_application_1/provider/ingreso_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future dialogCuentasvinc(BuildContext context, IngresoProvider provider) async {
  final DataGridController _dataGridController = DataGridController();
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.blueGrey,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Lista de facturas",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: SfDataGrid(
                  controller: _dataGridController,
                  source: DetalleDTS(provider, context),
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  headerRowHeight: 35.0,
                  selectionMode: SelectionMode.multiple,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'TD',
                        width: 40,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('TD',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        )),
                    GridColumn(
                        columnName: 'Documento',
                        width: 100,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Documento',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        )),
                    GridColumn(
                        columnName: 'Saldo',
                        width: 60,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Saldo',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        )),
                    GridColumn(
                        columnName: 'V.Aplica',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('V. Aplicar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    var _selectedRows = _dataGridController.selectedRows;
                    if (_selectedRows.isNotEmpty) {
                      for (var element in _selectedRows) {
                        provider.listselectFact
                            .add(element.getCells()[4].value);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text('Aceptar'),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  label: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
      });
}
