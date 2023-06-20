import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/rutas_api.dart';
import 'package:flutter_application_1/model/cc0020.dart';



class ObservacionProvider extends ChangeNotifier {
  List<Cc0020> listObservacion = [];
  final api = RutasApi();
  late Cc0020 obj;


}
