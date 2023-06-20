import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home_page.dart';
import 'package:flutter_application_1/screen/ingreso_page.dart';
import 'package:flutter_application_1/screen/login_signup.dart';

final routes = <String, WidgetBuilder>{
  'loginPage': (BuildContext context) => const LoginSignup(),
  'homePage': (BuildContext context) => const HomePage(),
  'ingresoPage': (BuildContext context) => const IngresoPage()
};
