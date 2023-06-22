import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/rutas_api.dart';
import 'package:flutter_application_1/model/cc0020.dart';

class IngresoProvider extends ChangeNotifier {
  //FORMULARIO
  final txtNombre = TextEditingController();
  final txtCodigo = TextEditingController();
  final txtTipoNGoNC = TextEditingController();
  final txtNumeroNG = TextEditingController();
  final txtCuentaV = TextEditingController();
  final txtValor = TextEditingController();
  final txtSaldo = TextEditingController();

  //dialogo
  final txtAbono = TextEditingController();
  final txtObservacion = TextEditingController();

  Cc0020? cabecera;
  List<Cc0020> listDetail = [];
  List<Cc0020> listselectFact = [];

  final api = RutasApi();

  initial() async {
    txtNombre.clear();
    txtCodigo.clear();
    txtTipoNGoNC.clear();
    txtSaldo.clear();
    txtValor.clear();
    txtObservacion.clear();
  }

  Future<String> getNombre(String codigo) async {
    String resp = await api.getMg0032Client("01", codigo);
    return resp;
  }

  Future getCuentas() async {
    var resp = await api.getCuentas(txtCuentaV.text, 'FC', '0');
    listDetail = resp;
  }

  Future getSValorySaldo() async {
    var resp = await api.getSValorySaldo(
        txtCodigo.text, txtTipoNGoNC.text, txtNumeroNG.text, "NA");
    if (resp.isNotEmpty) {
      cabecera = resp[0];
      txtValor.text = "${cabecera!.valMov}";
      txtSaldo.text = "${cabecera!.sdoMov}";
    }
  }

  Future removerCuenta(Cc0020 c) async {
    listselectFact.remove(c);
    notifyListeners();
  }
}
