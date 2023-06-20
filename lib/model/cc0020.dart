import 'dart:convert';

class Cc0020 {
  Cc0020({
    required this.codEmp,
    required this.codRef,
    required this.codPto,
    required this.codMov,
    required this.numMov,
    required this.ptoRel,
    required this.codRel,
    required this.numRel,
    required this.fecEmi,
    required this.fecVen,
    required this.valMov,
    required this.sdoMov,
    required this.codCob,
    required this.codBco,
    required this.numCta,
    required this.nunCta,
    required this.girador,
    required this.obsMov,
    required this.ptoNex,
    required this.codNex,
    required this.numNex,
    required this.fecNex,
    required this.fcrNex,
    required this.ncrNex,
    required this.codDiv,
    required this.cotDiv,
    required this.scsMov,
    required this.sosMov,
    required this.stsMov,
  });

  String codEmp;
  String codRef;
  String codPto;
  String codMov;
  String numMov;
  String ptoRel;
  String codRel;
  String numRel;
  DateTime fecEmi;
  DateTime fecVen;
  double valMov;
  double sdoMov;
  String codCob;
  String codBco;
  String numCta;
  String nunCta;
  String girador;
  String obsMov;
  String ptoNex;
  String codNex;
  String numNex;
  DateTime fecNex;
  String fcrNex;
  String ncrNex;
  String codDiv;
  double cotDiv;
  String scsMov;
  String sosMov;
  String stsMov;

  factory Cc0020.fromJson(String str) => Cc0020.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0020.fromMap(Map<String, dynamic> json) => Cc0020(
   codEmp:json["cod_emp"],
   codRef:json["cod_ref"],
   codPto:json["cod_pto"],
   codMov:json["cod_mov"],
   numMov:json["num_mov"],
   ptoRel:json["pto_rel"],
   codRel:json["cod_rel"],
   numRel:json["num_rel"],
   fecEmi:DateTime.parse(json["fec_emi"]),
   fecVen:DateTime.parse(json["fec_ven"]),
   valMov:json["val_mov"].toDouble(),
   sdoMov:json["sdo_mov"].toDouble(),
   codCob:json["cod_cob"],
   codBco:json["cod_bco"],
   numCta:json["num_cta"],
   nunCta:json["nun_cta"],
   girador:json["girador"],
   obsMov:json["obs_mov"],
   ptoNex:json["pto_nex"],
   codNex:json["cod_nex"],
   numNex:json["num_nex"],
   fecNex:DateTime.parse(json["fec_nex"]),
   fcrNex:json["fcr_nex"],
   ncrNex:json["ncr_nex"],
   codDiv:json["cod_div"],
   cotDiv:json["cot_div"].toDouble(),
   scsMov:json["scs_mov"],
   sosMov:json["sos_mov"],
   stsMov:json["sts_mov"],
    
             );

  Map<String, dynamic> toMap() => {
"cod_emp": codEmp,
"cod_ref": codRef,
"cod_pto": codPto,
"cod_mov": codMov,
"num_mov": numMov,
"pto_rel": ptoRel,
"cod_rel": codRel,
"num_rel": numRel,
"fec_emi": fecEmi,
"fec_ven": fecVen,
"val_mov": valMov,
"sdo_mov": sdoMov,
"cod_cob": codCob,
"cod_bco": codBco,
"num_cta": numCta,
"nun_cta": nunCta,
"girador": girador,
"obs_mov": obsMov,
"pto_nex": ptoNex,
"cod_nex": codNex,
"num_nex": numNex,
"fec_nex": fecNex,
"fcr_nex": fcrNex,
"ncr_nex": ncrNex,
"cod_div": codDiv,
"cot_div": cotDiv,
"scs_mov": scsMov,
"sos_mov": sosMov,
"sts_mov": stsMov,
  };

  }
