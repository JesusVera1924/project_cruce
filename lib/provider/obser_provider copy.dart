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

 saveCc0020(
      String observacion, String vendedor, DateTime fecha, String hora) async {
    obj = Cc0020(
        codEmp: "01",
        codRef: vendedor,
        codPto: "",
        codMov: hora,
        numMov: observacion,
        ptoRel: "",
        codRel: "p",
        numRel: "P",
        fecEmi: DateTime.now(),
        fecVen: DateTime.now(),
        valMov: 0,
        sdoMov: 0,
        codCob: "",
        codBco: "",
        numCta: "",
        nunCta: "",
        girador: "",
        obsMov: "",
        ptoNex: "",
        codNex: "",
        numNex: "",
        fecNex: DateTime.now(),
        fcrNex: "",
        ncrNex: "",
        codDiv: "",
        cotDiv: 0,
        scsMov: "",
        sosMov: "",
        stsMov: ""

        );

    await api.postComentario(obj);

    listObservacion.add(obj);
    notifyListeners();
  }
}
