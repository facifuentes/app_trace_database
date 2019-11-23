import 'package:flutter/material.dart';
import 'package:trace_database/bloc/schemaBLOC.dart';
import 'package:trace_database/ui/ui_data/dataReleaseUI.dart';
import 'package:trace_database/ui/ui_estructura/schemaReleaseUI.dart';


class HuellasTabsUI extends StatelessWidget {
  ///The detailhc is sent from hc_Patien_ui
  final String schema;
  HuellasTabsUI({this.schema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HuellasTabsListPage(
      schema: schema,
    ));
  }
}

class HuellasTabsListPage extends StatefulWidget {
  final String schema;
  HuellasTabsListPage({this.schema});

  @override
  _HuellasTabsState createState() => _HuellasTabsState(schema: schema);
}

class _HuellasTabsState extends State<HuellasTabsListPage> {
  final String schema;
  _HuellasTabsState({this.schema});
  SchemaBLOC consultBloc;
  TextEditingController editingController = TextEditingController();

  @override
  initState() {
    super.initState();
    consultBloc = SchemaBLOC();
    consultBloc.getAllReleasesbySchema(schema);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Estructura",
                ),
                Tab(
                  text: "Parámetros Config",
                ),
              ],
            ),
            title: const Text(
              "Huellas DB",
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: TabBarView(
            children: [
              SchemaReleaseUI(schema: schema,),
              DataReleaseUI(schema: schema,),
            ],
          ),
        
        ),
      ),
    );
  }
}
