// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/provider/ingreso_provider.dart';
import 'package:flutter_application_1/style/custom_inputs.dart';
import 'package:flutter_application_1/util/dialog_formulario.dart';
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
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.blueGrey,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Ingrese Abono",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text('Valor: '),
                      Expanded(
                        child: TextFormField(
                          controller: provider.txtSld,
                          decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Vinculados',
                            icon: Icons.format_list_numbered,
                          ),
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (codigo) async {
                            await provider.getSValorySaldo();
                            await dialogCuentasvinc(context, provider);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(9),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Text('Ingrese Abono: '),
                      Expanded(
                        child: TextFormField(
                          controller: provider.txtAbono,
                          decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Valor',
                            icon: Icons.monetization_on,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: provider.txtCodigo,
                          maxLines: 2,
                          decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Observación',
                            icon: Icons.abc,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      double valSaldo = double.parse(provider.txtSld.text);
                      double valAbonado = double.parse(provider.txtAbono.text);
                      
                      if (valAbonado <= valSaldo) {
                        //evento7
                        // ignore: unused_label
                        onChanged: (value) {
                              provider.calculateAbono();
                       
                            };
                      } else {
                        UtilView.messageDanger("El valor debe ser menor");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text('Acepta'),


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
