// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/datatable/vincular_datasource.dart';
import 'package:flutter_application_1/provider/ingreso_provider.dart';
import 'package:flutter_application_1/provider/login_provider.dart';
import 'package:flutter_application_1/style/custom_inputs.dart';
import 'package:flutter_application_1/util/dialog_formulario.dart';
import 'package:flutter_application_1/util/util_view.dart';
import 'package:flutter_application_1/widget/white_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IngresoPage extends StatefulWidget {
  const IngresoPage({Key? key}) : super(key: key);

  @override
  State<IngresoPage> createState() => _IngresoPageState();
}

class _IngresoPageState extends State<IngresoPage> {
  late FocusNode myFocusNodeTipo;
  late FocusNode myFocusNodeNumero;
  late FocusNode myFocusNodeVinc;

  @override
  void initState() {
    Provider.of<IngresoProvider>(context, listen: false).initial();
    Provider.of<LoginProvider>(context, listen: false).getValues();
    myFocusNodeTipo = FocusNode();
    myFocusNodeNumero = FocusNode();
    myFocusNodeVinc = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IngresoProvider>(context);
    final providerLogin = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cruce de notas'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      body: ListView(
        children: [
          WhiteCard(
            title: '  ',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VENDEDOR: ${providerLogin.codigo}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(providerLogin.nombre.trim(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: provider.txtCodigo,
                        decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Codigo', icon: Icons.numbers),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (codigo) async {
                          final resp = await provider.getNombre(codigo);
                          if (resp != "") {
                            provider.txtNombre.text = resp;
                            FocusScope.of(context)
                                .requestFocus(myFocusNodeTipo);
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: provider.txtNombre,
                          enabled: false,
                          maxLines: 1,
                          decoration: size.width < 10
                              ? CustomInputs.boxInputDecoration3(
                                  hint: 'Nombre del cliente',
                                  icon: Icons.person)
                              : CustomInputs.boxInputDecoration2(
                                  hint: 'Nombre del cliente',
                                  icon: Icons.person),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(250),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: provider.txtTipoNGoNC,
                        focusNode: myFocusNodeTipo,
                        decoration: CustomInputs.boxInputDecoration2(
                            hint: 'NG/NC', icon: Icons.format_list_numbered),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization
                            .characters, // Establecer en mayúscula predeterminada

                        onFieldSubmitted: (value) {
                          if (value != "") {
                            FocusScope.of(context)
                                .requestFocus(myFocusNodeNumero);
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: provider.txtNumeroNG,
                        focusNode: myFocusNodeNumero,
                        decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Numero de la NG',
                            icon: Icons.format_list_numbered),
                        onFieldSubmitted: (value) {
                          if (value != "") {
                            provider.getSValorySaldo();
                            FocusScope.of(context)
                                .requestFocus(myFocusNodeVinc);
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // ignore: avoid_unnecessary_containers
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: myFocusNodeVinc,
                        controller: provider.txtCuentaV,
                        decoration: CustomInputs.boxInputDecoration2(
                          hint: 'Vinculados',
                          icon: Icons.format_list_numbered,
                        ),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (codigo) async {
                          await provider.getCuentas();
                          await dialogCuentasvinc(context, provider);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        enabled: false,
                        controller: provider.txtValor,
                        decoration: CustomInputs.boxInputDecoration2(
                          hint: 'Valor',
                          icon: Icons.monetization_on_outlined,
                        ),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (codigo) async {
                          await provider.getCuentas();
                          await dialogCuentasvinc(context, provider);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        enabled: false,
                        controller: provider.txtSaldo,
                        decoration: CustomInputs.boxInputDecoration2(
                          hint: 'Saldo',
                          icon: Icons.money_off_csred,
                        ),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (codigo) async {
                          await provider.getCuentas();
                          await dialogCuentasvinc(context, provider);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          WhiteCard(
              title: 'Detalle',
              child: Column(
                children: [
                  SfDataGrid(
                    source: VincularDTS(provider, context),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    headerRowHeight: 35.0,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'TD',
                          width: 37,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('TD',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'Documento',
                          width: 90,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Documento',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'Saldo',
                          width: 75,
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Saldo',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'V.Aplicar',
                          width: 75,
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('V.Aplicar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'Elim',
                          width: 50,
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('E',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'Apli',
                          width: 45,
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('A',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}


     /* final dataGridController = DataGridController();
                          await provider
                              .getClientxVendedor(providerLogin.codigo);

                          if (provider.listAux.isNotEmpty) {
                            provider.listClienteTemp = await dialogMultiple(
                                context,
                                'Lista de clientes'.toUpperCase(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SfDataGrid(
                                          source: ClienteDTS(
                                              provider.listAux, context),
                                          headerRowHeight: 30.0,
                                          rowHeight: 30.0,
                                          controller: dataGridController,
                                          showCheckboxColumn: true,
                                          selectionMode: SelectionMode.multiple,
                                          columns: [
                                            GridColumn(
                                                columnName: 'codigo',
                                                columnWidthMode: ColumnWidthMode
                                                    .fitByColumnName,
                                                label: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Codigo',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                            GridColumn(
                                                columnName: 'nombre',
                                                columnWidthMode:
                                                    ColumnWidthMode.fill,
                                                label: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Cliente',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                          ]),
                                    ],
                                  ),
                                ),
                                Icons.schedule_sharp,
                                Colors.red,
                                dataGridController,
                                provider);

                            if (provider.listClienteTemp.isNotEmpty) {
                              provider.txtCliente.text =
                                  provider.listClienteTemp.toString();
                            } else {
                              provider.txtCliente.clear();
                            }
                          }
                          provider.optTest();
                          provider.addDetail(providerLogin.codigo); */
                     