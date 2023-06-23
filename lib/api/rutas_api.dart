import 'dart:convert';

import 'package:flutter_application_1/model/cc0020.dart';
import 'package:flutter_application_1/model/cc0751.dart';

import 'package:flutter_application_1/model/empresa.dart';
import 'package:flutter_application_1/model/mg0001.dart';
import 'package:flutter_application_1/model/mg0030.dart';
import 'package:flutter_application_1/model/sendmailer.dart';
import 'package:flutter_application_1/model/yk0001.dart';
import 'package:flutter_application_1/util/util_view.dart';
import 'package:http/http.dart' as http;

class RutasApi {
  static String urlBase = "192.168.3.56:8084";
  static String pathBase = "/contabilidad";
  static String pathBase2 = "/desarrollosolicitud";

  Future<Empresa> getSettingEmp(String emp) async {
    Empresa dato;
    var url =
        Uri.http("192.168.3.4:8081", '$pathBase2/getempresa', {'empresa': emp});
    (url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Empresa.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  List<Empresa> parseJsonToList(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Empresa>((json) => Empresa.fromMap(json)).toList();
  }

  Future<Yk0001?> login(String usuario, String pass) async {
    Yk0001? dato;

    var url = Uri.http(
        urlBase, '$pathBase/loginMovil', {'usuario': usuario, 'pass': pass});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = respuesta.body.toString() != "[]"
            ? parseListYk0001(utf8.decode(respuesta.bodyBytes)).first
            : null;
      } else {
        // print('Excepcion ${respuesta.statusCode}');
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      // print(e);
      throw ('error el en GET: $e');
    }
    return dato;
  }

  List<Yk0001> parseListYk0001(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Yk0001>((json) => Yk0001.fromMap(json)).toList();
  }

  Future<String> getNombre(String emp, String codigo) async {
    var url = Uri.http(urlBase, '$pathBase/getNombreMg0032',
        {'empresa': emp, 'cliente': codigo});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> postCabecera(Cc0751 cabecera) async {
    String resp = "0";
    var url = Uri.http(urlBase, '$pathBase/saveCc0751');

    var data = cabecera.toJson();

    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
    return resp;
  }

  //print(data);

  List<Mg0030> parseObservaciones(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0030>((json) => Mg0030.fromMap(json)).toList();
  }

  Future<String> getVerificacionruta(String fec, String ven) async {
    var url = Uri.http(
        urlBase, '$pathBase/getCc0751Ext', {'fecha': fec, 'vendedor': ven});

    // print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> getMg0032Client(String empresa, String ven) async {
    String resul = "";

    var url = Uri.http(urlBase, '$pathBase/getNombreMg0032',
        {'empresa': empresa, 'cliente': ven});

    // print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<List<Cc0020>> getCuentas(
      String codigo, String movimiento, String estado) async {
    List<Cc0020> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getCuentasV',
        {'codRef': codigo, 'codMov': movimiento, 'sdoMov': estado});

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelCc0020(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }

    return resul;
  }

  Future<List<Cc0020>> getSValorySaldo(
      String codigo, String codMov, String nummov, String codrel) async {
    List<Cc0020> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getValorySaldo', {
      'codRef': codigo,
      'codMov': codMov,
      'numMov': nummov,
      'codRel': codrel
    });

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelCc0020(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }

    return resul;
  }

  List<Cc0020> parseModelCc0020(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0020>((json) => Cc0020.fromMap(json)).toList();
  }

  Future<String> postComentario(Cc0020 comentario) async {
    var url = Uri.http(urlBase, '$pathBase/saveCc0753');

    var data = comentario.toJson();

    // print(data);

    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode == 200) {
      return resquet.body;
    } else {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
  }

  Future<List<Mg0001>> getMg0001(String s) async {
    List<Mg0001> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getMg0001', {});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelMg0001(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Mg0001> parseModelMg0001(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0001>((json) => Mg0001.fromMap(json)).toList();
  }

  Future<String> sendMailerDocument(
      String numero, String name, String base) async {
    var url = Uri.http(urlBase, '$pathBase/sendCorreoR');
    var data = SendMaileRuta(
            numRef: numero,
            codRef: UtilView.codigoNombre,
            nomRef: UtilView.nombreVen,
            name: name,
            body: base)
        .toJson();
    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200) {
        throw Exception('Error de formulario,: ${resquet.statusCode}');
      } else {
        return resquet.body;
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Cc0751>> getCc0751List(String vendedor) async {
    List<Cc0751> resul = [];

    var url =
        Uri.http(urlBase, '$pathBase/getCc0751Rutas', {'vendedor': vendedor});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelCc0751(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cc0751> parseModelCc0751(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0751>((json) => Cc0751.fromMap(json)).toList();
  }
}
