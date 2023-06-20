import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/rutas_api.dart';
import 'package:flutter_application_1/model/cc0020.dart';


class ObservacionProvider extends ChangeNotifier {
  List<Cc0020> listObservacion = [];
  final api = RutasApi();
  late Cc0020 obj;

  obtenerList(String codigo) async {
    listObservacion = await api.getCuentas("01", codigo,codigo);
    notifyListeners();
  }

 /* saveCc0753(
      String observacion, String vendedor, DateTime fecha, String hora) async {
    obj = Cc0020(
        codEmp: "01",
        rvcAct: vendedor,
        fecAct: fecha,
        hraAct: hora,
        obsAct: observacion,
        fytAct: DateTime.now().add(const Duration(hours: -5)),
        srsAct: "p",
        stsAct: "P");

    await api.postComentario(obj);

    listObservacion.add(obj);
    notifyListeners();
  }*/
}
