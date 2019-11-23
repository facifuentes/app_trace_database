import 'package:flutter/material.dart';
import 'package:trace_database/ui/ui_data/ComparationDataUI.dart';
import 'package:trace_database/bloc/DataBLOC.dart';
import 'package:trace_database/models/ReleaseDB.dart';
import 'package:trace_database/models/ReleaseSchema.dart';
import 'package:trace_database/models/errorapi_model.dart';

import 'package:trace_database/utils/item_list_tile.dart';
import 'package:trace_database/utils/messageDialog.dart';

class DetailDataReleaseUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui
  final String schema;
  final String idRelease;
  DetailDataReleaseUI({this.schema, this.idRelease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DetailDataReleaseListPage(
      schema: schema,
      idRelease: idRelease,
    ));
  }
}

class DetailDataReleaseListPage extends StatefulWidget {
  final String schema;
  final String idRelease;
  DetailDataReleaseListPage({this.schema, this.idRelease});

  @override
  _DetailDataReleasetate createState() =>
      _DetailDataReleasetate(schema: schema, idRelease: idRelease);
}

class _DetailDataReleasetate extends State<DetailDataReleaseListPage> {
  final String schema;
  final String idRelease;
  _DetailDataReleasetate({this.schema, this.idRelease});
  DataBLOC consultBloc;
  TextEditingController editingController = TextEditingController();
  ReleaseSchema _releaseSchema;
  @override
  initState() {
    super.initState();
    consultBloc = DataBLOC();
    consultBloc.getDataRelease(idRelease);
    consultBloc.getAllDataReleasesbySchema(schema);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalle Huella",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: consultBloc.releaselList,
        builder: (BuildContext contex, snapData) {
          if (!snapData.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return cargaLista(
              snapData.data, consultBloc, editingController, context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          if (consultBloc.listDropdown.length == 0) {
            _warnCreateBaseLine().then(
              (response) {
                if (response) {
                  consultBloc
                      .updateDataBaseLine(schema, idRelease, idRelease)
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
            );
          } else {
            releasepopup(context).then(
              (response) {
                if (response) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ComparationDataUI(
                            schema: schema,
                            idReleaseN: idRelease,
                            idReleaseA: _releaseSchema.release,
                          )));
                }
              },
            );
          }
        },
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }

  Widget cargaLista(
    List<ReleaseDB> snapData,
    DataBLOC consultBloc,
    TextEditingController editingController,
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Detalle de la huella " + idRelease + " del esquema " + schema,
              style: TextStyle(fontSize: 18),
            )),
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
                          description: snapData[index].campo,
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ItemListTile(
                                title: "Huella: ",
                                description: snapData[index].huella,
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
                          color: Colors.black,
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
