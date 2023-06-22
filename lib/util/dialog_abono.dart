import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/ingreso_provider.dart';
import 'package:flutter_application_1/style/custom_inputs.dart';
import 'package:flutter_application_1/util/util_view.dart';

Future dialogAbono(BuildContext context, IngresoProvider provider) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.blueGrey,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Ingrese Abono",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Saldo: 4.00'),
                  Row(children: [
                    const Text('Ingrese Abono: '),
                    Expanded(
                      child: TextFormField(
                          controller: provider.txtAbono,
                          decoration: CustomInputs.boxInputDecoration2(
                              hint: 'Valor', icon: Icons.numbers),
                          keyboardType: TextInputType.number),
                    ),
                  ]),
                  const SizedBox(height: 18),
                  Row(children: [
                    const Text('Observación:'),
                    Expanded(
                      child: TextFormField(
                          controller: provider.txtObservacion,
                          decoration: CustomInputs.boxInputDecoration2(
                              hint: 'Obs', icon: Icons.abc),
                          keyboardType: TextInputType.text),
                    ),
                  ])
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      double valSaldo = double.parse(provider.txtSaldo.text);
                      double valAbonado = double.parse(provider.txtAbono.text);
                      if (valAbonado <= valSaldo) {
                        //evento7
                        Navigator.of(context).pop();
                      } else {
                        UtilView.messageDanger("Error");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text('Aceptar'),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  label: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
      });
}
