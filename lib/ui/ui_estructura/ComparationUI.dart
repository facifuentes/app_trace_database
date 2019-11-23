import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:trace_database/bloc/schemaBLOC.dart';
import 'package:trace_database/models/ComparationDB.dart';
import 'package:trace_database/models/ReleaseSchema.dart';
import 'package:trace_database/models/errorapi_model.dart';

import 'package:trace_database/utils/item_list_tile.dart';
import 'package:trace_database/utils/messageDialog.dart';

class ComparationUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui
  final String schema;
  final String idReleaseN;
  final String idReleaseA;
  ComparationUI({this.schema, this.idReleaseN, this.idReleaseA});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ComparationListPage(
            schema: schema, idReleaseN: idReleaseN, idReleaseA: idReleaseA));
  }
}

class ComparationListPage extends StatefulWidget {
  final String schema;
  final String idReleaseN;
  final String idReleaseA;
  ComparationListPage({this.schema, this.idReleaseN, this.idReleaseA});

  @override
  _Comparationtate createState() => _Comparationtate(
      schema: schema, idReleaseN: idReleaseN, idReleaseA: idReleaseA);
}

class _Comparationtate extends State<ComparationListPage> {
  final String schema;
  final String idReleaseN;
  final String idReleaseA;
  _Comparationtate({this.schema, this.idReleaseN, this.idReleaseA});
  SchemaBLOC consultBloc;
  TextEditingController editingController = TextEditingController();
  ReleaseSchema _releaseSchema;
  @override
  initState() {
    super.initState();
    AutoOrientation.landscapeAutoMode();
    consultBloc = SchemaBLOC();
    consultBloc.comparation(schema, idReleaseN, idReleaseA);
  }

  @override
  void dispose() {
    super.dispose();
    AutoOrientation.portraitAutoMode();
  }

  String validateNull(obj) {
    String data = "";
    if (obj != null) {
      data = obj;
    }
    return data;
  }

  SingleChildScrollView dataBody(List<ComparationDB> comparation) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: DataTable(
          columnSpacing: 10,
          dataRowHeight: 70,
          columns: [
            DataColumn(
              label: Text(
                "Campo",
              ),
              numeric: false,
              tooltip: "",
            ),
            DataColumn(
              label: Text(
                "Estructura Actual",
              ),
              numeric: false,
              tooltip: "",
            ),
            DataColumn(
              label: Text(
                "Huella Actual",
              ),
              numeric: false,
              tooltip: "",
            ),
            DataColumn(
              label: Text(
                "Estructura Base",
              ),
              numeric: false,
              tooltip: "",
            ),
            DataColumn(
              label: Text(
                "Huella Base",
              ),
              numeric: false,
              tooltip: "",
            ),
            DataColumn(
              label: Text(
                "Estado",
              ),
              numeric: false,
              tooltip: "",
            ),
          ],
          rows: comparation
              .map(
                (comparat) => DataRow(cells: [
                  //Fecha Actividad
                  DataCell(Center(
                    child: Text(validateNull(comparat.camponuevo)),
                  )),

                  DataCell(
                    Container(
                      child: Text(
                        validateNull(comparat.estructuranueva),
                        maxLines: 10,
                      ),
                      width: 100,
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        validateNull(comparat.huellanueva),
                        maxLines: 10,
                      ),
                      width: 200,
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        validateNull(comparat.estructuraanterior),
                        maxLines: 10,
                      ),
                      width: 100,
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        validateNull(comparat.huellaanterior),
                        maxLines: 10,
                      ),
                      width: 200,
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        comparat.estado,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text("Detalle Huella"),
          Spacer(),
          IconButton(
            icon: Icon(Icons.save, color: Colors.white, size: 28),
            onPressed: () => _warnCreateBaseLine().then(
              (response) {
                if (response) {
                  consultBloc
                      .updateBaseLine(schema, idReleaseN, idReleaseA)
                      .then((registryConfirmed) {
                    if (registryConfirmed) {
                      MessageDialog().warnCreationConfirmed(
                          context, "Linea Base actualizada", "", false);
                    } else {
                      MessageDialog().warnIssue(
                          context,
                          ErrorApiResponse(
                              message:
                                  "No es posible actualizar la linea base"));
                    }
                  });
                }
              },
            ),
          )
        ]),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: consultBloc.compareList,
        builder: (BuildContext contex, snapData) {
          if (!snapData.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      child: ItemListTile(
                        title: "Huella Actual: ",
                        description: idReleaseN,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      child: ItemListTile(
                        title: "Huella Base:  ",
                        description: idReleaseA,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    flex: 1,
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              dataBody(snapData.data),
            ],
          );
        },
      ),
    );
  }

  Widget cargaLista(
    List<ComparationDB> snapData,
    SchemaBLOC consultBloc,
    TextEditingController editingController,
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Detalle de la huella " +
                idReleaseA +
                " del esquema " +
                schema)),
        (snapData.isEmpty)
            ? Expanded(
                child: Center(
                child: Text("No hay datos"),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: snapData.length,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: ItemListTile(
                          title: "Campo: ",
                          description: snapData[index].camponuevo,
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ItemListTile(
                                title: "Estructura Anterior: ",
                                description: snapData[index].estructuraanterior,
                              ),
                              ItemListTile(
                                title: "Huella Anterior: ",
                                description: snapData[index].huellaanterior,
                              ),
                              ItemListTile(
                                title: "Estructura Nueva: ",
                                description: snapData[index].estructuranueva,
                              ),
                              ItemListTile(
                                title: "Huella Nueva: ",
                                description: snapData[index].huellanueva,
                              ),
                              ItemListTile(
                                title: "Estado: ",
                                description: snapData[index].estado,
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Future<bool> releasepopup(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                void changedDropDownItemD(ReleaseSchema releaseSchema) {
                  setState(() {
                    _releaseSchema = releaseSchema;
                  });
                }

                return AlertDialog(
                  title: Text(
                      "Por favor seleccione la huella con la que desea validar:"),
                  // contentPadding: EdgeInsets.only(
                  //     top: deviceSize.height * 0.00000000000009),
                  content: Container(
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: deviceSize.width / 35,
                    //     vertical: deviceSize.height * 0.001),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.white54, width: 1.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ReleaseSchema>(
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                        ),
                        isExpanded: true,
                        hint: Text("Seleccione una huella"),
                        items: consultBloc.listDropdown,
                        value: _releaseSchema,
                        onChanged: changedDropDownItemD,
                      ),
                    ),
                  ),

                  actions: <Widget>[
                    FlatButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        //Cierra el popup
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      child: const Text("Aceptar"),
                      onPressed: () {
                        //Cierra el popup
                        Navigator.pop(context, true);
                        // Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ) ??
        false;
  }

  Future<bool> _warnCreateBaseLine() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: const Text(
                  "¿Esta seguro que desea asignar la huella actual como Linea Base?"),
              actions: <Widget>[
                FlatButton(
                  child: const Text("Si"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
