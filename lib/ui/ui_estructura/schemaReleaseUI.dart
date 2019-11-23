import 'package:flutter/material.dart';
import 'package:trace_database/bloc/schemaBLOC.dart';
import 'package:trace_database/ui/ui_estructura/detailReleaseUI.dart';
import 'package:trace_database/models/ReleaseSchema.dart';

import 'package:trace_database/models/errorapi_model.dart';
import 'package:trace_database/utils/commons.dart';

import 'package:trace_database/utils/item_list_tile.dart';
import 'package:trace_database/utils/messageDialog.dart';

class SchemaReleaseUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui
  final String schema;
  SchemaReleaseUI({this.schema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SchemaReleaseListPage(
      schema: schema,
    ));
  }
}

class SchemaReleaseListPage extends StatefulWidget {
  final String schema;
  SchemaReleaseListPage({this.schema});

  @override
  _SchemaReleaseState createState() => _SchemaReleaseState(schema: schema);
}


class _SchemaReleaseState extends State<SchemaReleaseListPage> {
  final String schema;
  _SchemaReleaseState({this.schema});
  SchemaBLOC consultBloc;
  TextEditingController editingController = TextEditingController();

  @override
  initState() {
    super.initState();
    consultBloc = SchemaBLOC();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    consultBloc.getAllReleasesbySchema(schema);
    return  Scaffold(
          body: 
          StreamBuilder(
            stream: consultBloc.reschemaList,
            builder: (BuildContext context, snapData) {
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
            onPressed: () => _warnCreateTrace().then((response) {
              if (response) {
                consultBloc.createReleaseDB(schema).then((registryConfirmed) {
                  if (registryConfirmed) {
                    MessageDialog().warnCreationConfirmed(
                        context, "Huella creada correctamente", "", false);
                  } else {
                    MessageDialog().warnIssue(
                        context,
                        ErrorApiResponse(
                            message: "No es posible crear la huella"));
                  }
                });
              }
            }),
            child: Icon(
              Icons.add,
            ),
          ),
        );
      
    
  }

  Widget cargaLista(
    List<ReleaseSchema> snapData,
    SchemaBLOC consultBloc,
    TextEditingController editingController,
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Listado de huellas creadas al esquema " + schema,
              style: TextStyle(fontSize: 18),
            )),
        (snapData.isEmpty)
            ? Expanded(
                child: Center(
                child: Text("No hay huellas creadas"),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: snapData.length,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DetailReleaseUI(
                              schema: snapData[index].esquema,
                              idRelease: snapData[index].release,
                            ),
                          ));
                        },
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (snapData[index].baseLine)
                                  ? ItemListTile(
                                      title: "Linea Base",
                                      description: "",
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              ItemListTile(
                                title: "Id: ",
                                description: snapData[index].release,
                              ),
                            ]),
                        subtitle: ItemListTile(
                          title: "Fecha: ",
                          description: CommonsSM()
                              .formatDateWhitTime(snapData[index].fecha),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Future<bool> _warnCreateTrace() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: const Text(
                  "¿Esta seguro que desea sacar una huella al esquema actual?"),
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
