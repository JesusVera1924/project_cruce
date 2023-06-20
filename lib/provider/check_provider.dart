import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/rutas_api.dart';

import 'package:flutter_application_1/model/mg0032.dart';
import 'package:flutter_application_1/util/util_view.dart';

import 'package:intl/intl.dart';

class CheckProvider extends ChangeNotifier {
  //----------------------------------------------------------------------------

  final txtRvc = TextEditingController();
  final txtFec = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final txtNum = TextEditingController();
  final txtCta = TextEditingController();
  final txtTvc = TextEditingController();
  final txtTer = TextEditingController();
  final txtValue = TextEditingController();
  final txtCov = TextEditingController();
  final txtObs = TextEditingController();
  final txtFvs = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  final txtSgt = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  //----------------------------------------------------------------------------

  bool isTpVisita = false;
  bool isBusqueda = false;
  bool isObservacion = false;
  bool isSelect = true;

  List<Mg0032> listCliente = [];
  List<Mg0032> listAntCliente = [];
  late Mg0032 isCliente;

  final api = RutasApi();

  String obtenerTipo(String x) {
    String resp = "[";
    if (x.contains("V")) {
      resp += "Venta ";
    }
    if (x.contains("C")) {
      resp += " Cobro ";
    }
    if (x.contains("D")) {
      resp += " Devoluciòn";
    }
    return "$resp]";
  }

  clearObjeto() {
    txtRvc.clear();
    txtFec.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txtNum.clear();
    txtCta.clear();
    txtTvc.clear();
    txtTer.clear();
    txtCov.clear();
    txtObs.clear();
    txtValue.clear();
    txtFvs.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    isTpVisita = false;
    isBusqueda = false;
    isObservacion = false;
    notifyListeners();
  }

  clearObjeto2() {
    txtRvc.clear();
    txtFec.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txtNum.clear();
    txtCta.clear();
    txtTvc.clear();
    txtTer.clear();
    txtCov.clear();
    txtObs.clear();
    txtValue.clear();
    txtFvs.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    isTpVisita = false;
    isBusqueda = false;
    isObservacion = false;
  }

  Future<List> getListRutas(String vendedor) async {
    var list = await api.getCc0751List(vendedor);
    return list;
  }

  Future<String> getNombre(String codRef) async {
    var x = await api.getMg0032Client(UtilView.empresa.codEmp, codRef);
    return x;
  }
}
