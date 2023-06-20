import 'package:flutter_application_1/model/cc0020.dart';
import 'package:flutter_application_1/provider/ingreso_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class VincularDTS extends DataGridSource {
  VincularDTS(this.provider, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  final IngresoProvider provider;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = provider.listselectFact.map<DataGridRow>((Cc0020 team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'TD', value: team.codMov),
        DataGridCell<String>(columnName: 'Documento.', value: team.numMov),
        DataGridCell<double>(columnName: 'Saldo', value: team.valMov),
        DataGridCell<double>(columnName: 'V.aplicar', value: team.sdoMov),
        DataGridCell<Cc0020>(columnName: 'event', value: team),
        DataGridCell<Cc0020>(columnName: 'apl', value: team),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(row.getCells()[0].value.toString(),
              textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(
            row.getCells()[1].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Tooltip(
          message: row.getCells()[3].value.toString(),
          child: Text(
            row.getCells()[3].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: InkWell(
            onTap: () {
              provider.removerCuenta(row.getCells()[4].value);
            },
            child: const Icon(Icons.delete, color: Colors.red)),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: InkWell(
            onTap: () {
              provider.removerCuenta(row.getCells()[5].value);
            },
            child: const Icon(Icons.add, color: Colors.black)),
      ),
    ]);
  }
}
