import 'dart:convert';
import 'dart:ffi';

class Mg0032v {
  Mg0032v({
    required this.codEmp,
    required this.codRef,
    required this.codVin,
    required this.ordVin,
  });

  String codEmp;
  String codRef;
  String codVin;
  Double ordVin;

  factory Mg0032v.fromJson(String str) => Mg0032v.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mg0032v.fromMap(Map<String, dynamic> json) => Mg0032v(
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        codVin: json["cod_vin"],
        ordVin: json["ord_vin"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "cod_vin": codVin,
        "ord_vin": ordVin,
        
      };
}
