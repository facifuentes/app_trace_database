import 'package:flutter/material.dart';
import 'package:trace_database/ui/HuellaTabsUI.dart';
import 'package:trace_database/bloc/schemaBLOC.dart';
import 'package:trace_database/models/Schema.dart';

import 'package:trace_database/utils/item_list_tile.dart';

class HomeUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui

  HomeUI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeUIListPage());
  }
}

class HomeUIListPage extends StatefulWidget {

  HomeUIListPage();

  @override
  _HomeListPageState createState() =>
      _HomeListPageState();
}

class _HomeListPageState extends State<HomeUIListPage> {

  _HomeListPageState();
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
    consultBloc.initializeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inicio",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: consultBloc.schemaList,
        builder: (BuildContext contex, snapData) {
          if (!snapData.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return cargaLista(snapData.data, consultBloc, editingController,
              context);
        },
      ),
     
    );
  }

  Widget cargaLista(
      List<Schema> snapData,
      SchemaBLOC consultBloc,
      TextEditingController editingController,
      BuildContext context,
      ) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:Text("Listado de esquemas actuales", style: TextStyle(fontSize: 18),)
        ),
        (snapData.isEmpty)
            ? Expanded(
                child: Center(
                child: Text("No hay esquemas"),
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
                            builder: (BuildContext context) =>
                                HuellasTabsUI(schema: snapData[index].esquema,
                            ),
                          ));
                        },
                        title: ItemListTile(
                          title: "Esquema: ",
                          description: snapData[index].esquema,
                        ),
                        
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
