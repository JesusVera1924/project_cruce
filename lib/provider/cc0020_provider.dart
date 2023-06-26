import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/rutas_api.dart';
import 'package:flutter_application_1/model/cc0020.dart';

import 'package:flutter_application_1/util/util_view.dart';

class ObservacionProvider extends ChangeNotifier {
  List<Cc0020> listObservacion = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Cc0020 cc0020;
  final api = RutasApi();
  late Cc0020 obj;
  final txtNombre = TextEditingController();
  final txtCodigo = TextEditingController();
  final txtTipoNGoNC = TextEditingController();
  final txtNumeroNG = TextEditingController();
  final txtCuentaV = TextEditingController();
  final txtValor = TextEditingController();
  final txtSaldo = TextEditingController();
  final txtObservacion = TextEditingController();

  obtenerList(String codigo) async {
    listObservacion = await api.getCuentas("01", codigo, codigo);
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
        stsMov: "");

    await api.postComentario(obj);

    listObservacion.add(obj);
    notifyListeners();
  }

  Future<bool> save() async {
    try {
      final list = await api.postCc0020(obj);
      // facturas.clear();
      //tempfacturas = list;
      notifyListeners();
      UtilView.messageAccess("Cruce realizado con exito", Colors.blue);
      return list.isNotEmpty;
    } catch (e) {
      UtilView.messageDanger('$e');
    }
    return false;
  }

  Future update() async {
    if (validateForm()) {
      try {
        cc0020.codEmp = "01";
        cc0020.codRef = "";
        cc0020.codPto = "";
        cc0020.codMov = "DX";
        cc0020.numMov = txtNumeroNG.text;
        cc0020.ptoRel = "";
        cc0020.codRel = "";
        cc0020.numRel = ""; //OJO
        cc0020.fecEmi = DateTime.now();
        cc0020.fecVen = DateTime.now();
        cc0020.valMov = 0;
        cc0020.sdoMov = 0;
        cc0020.codCob = "null";
        cc0020.codBco = "null";
        cc0020.numCta = "null";
        cc0020.nunCta = "null";
        cc0020.girador = "girador";
        cc0020.obsMov = txtObservacion.text;
        cc0020.ptoNex = "";
        cc0020.codNex = "null";
        cc0020.numNex = "null";
        cc0020.fecNex = DateTime.now();
        cc0020.codDiv = "girador";
        cc0020.cotDiv = 1;
        cc0020.stsMov = "";
        bool op = (await api.putCg0020(cc0020)) as bool;
        if (op) {
          // Code to handle successful operation
        }
        UtilView.messageAccess(
            'Pago directo, modificado con éxito', Colors.black);
        notifyListeners();
      } catch (e) {
        throw e.toString();
      }
    }
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
