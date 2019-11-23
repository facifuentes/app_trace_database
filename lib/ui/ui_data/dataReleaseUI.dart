import 'package:flutter/material.dart';
import 'package:trace_database/bloc/dataBLOC.dart';
import 'package:trace_database/ui/ui_data/detailDataReleaseUI.dart';

import 'package:trace_database/models/ReleaseSchema.dart';

import 'package:trace_database/models/errorapi_model.dart';
import 'package:trace_database/utils/commons.dart';

import 'package:trace_database/utils/item_list_tile.dart';
import 'package:trace_database/utils/messageDialog.dart';

class DataReleaseUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui
  final String schema;
  DataReleaseUI({this.schema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DataReleaseListPage(
      schema: schema,
    ));
  }
}

class DataReleaseListPage extends StatefulWidget {
  final String schema;
  DataReleaseListPage({this.schema});

  @override
  _DataReleaseState createState() => _DataReleaseState(schema: schema);
}


class _DataReleaseState extends State<DataReleaseListPage> {
  final String schema;
  _DataReleaseState({this.schema});
  DataBLOC consultBloc;
  TextEditingController editingController = TextEditingController();

  @override
  initState() {
    super.initState();
    consultBloc = DataBLOC();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    consultBloc.getAllDataReleasesbySchema(schema);
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
                consultBloc.createDataReleaseDB(schema).then((registryConfirmed) {
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
    DataBLOC consultBloc,
    TextEditingController editingController,
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Listado de huellas creadas a los parametros de configuración del esquema " + schema,
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
                            builder: (BuildContext context) => DetailDataReleaseUI(
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
