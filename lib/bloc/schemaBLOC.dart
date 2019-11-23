import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trace_database/models/ComparationDB.dart';
import 'package:trace_database/models/ReleaseDB.dart';
import 'package:trace_database/models/ReleaseSchema.dart';
import 'package:trace_database/models/Schema.dart';
import 'package:trace_database/models/apiresponse_model.dart';
import 'package:trace_database/repository/repository.dart';

class SchemaBLOC {
  final _repository = Repository();
  var _apiResponse = ApiResponse();
  String _idRelease = "";

  SchemaBLOC();
  final _schemaListController = StreamController<List<Schema>>.broadcast();
  List<Schema> _initialList;
  Stream<List<Schema>> get schemaList =>
      _schemaListController.stream.asBroadcastStream();
  Future initializeData() async {
    ApiResponse apiResponse = await _repository.getAllSchemas();
    if (apiResponse.statusResponse == 200) {
      _initialList = apiResponse.object;
      _schemaListController.add(_initialList);
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  final _reschemaListController =
      StreamController<List<ReleaseSchema>>.broadcast();
  List<ReleaseSchema> _releaseSchemalList;
  List<ReleaseSchema> get releasesScheme => _releaseSchemalList;
  Stream<List<ReleaseSchema>> get reschemaList =>
      _reschemaListController.stream.asBroadcastStream();

  Future getAllReleasesbySchema(String schema) async {
    ApiResponse apiResponse = await _repository.getAllReleasesbySchema(schema);
    if (apiResponse.statusResponse == 200) {
      _releaseSchemalList = apiResponse.object;
      _reschemaListController.add(_releaseSchemalList);
      chargeDrop();
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  final _getReleaseListController =
      StreamController<List<ReleaseDB>>.broadcast();
  List<ReleaseDB> _releaselList;
  Stream<List<ReleaseDB>> get releaselList =>
      _getReleaseListController.stream.asBroadcastStream();

  Future getRelase(String schema, String idRelease) async {
    _idRelease = idRelease;
    ApiResponse apiResponse = await _repository.getRelease(schema, idRelease);
    if (apiResponse.statusResponse == 200) {
      _releaselList = apiResponse.object;
      _getReleaseListController.add(_releaselList);
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  Future<bool> createReleaseDB(String schema) async {
    ApiResponse apiResponse = await _repository.createReleaseDB(schema);
    if (apiResponse.statusResponse == 200) {
      //_releaseSchemalList = apiResponse.object;
      getAllReleasesbySchema(schema);
      return true;
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
      return false;
    }
  }

  List<DropdownMenuItem<ReleaseSchema>> listDropdown =
      List<DropdownMenuItem<ReleaseSchema>>();

  chargeDrop() {
    for (ReleaseSchema data in _releaseSchemalList) {
      if (data.release != _idRelease) {
        listDropdown.add(DropdownMenuItem(
            value: data,
            child: Text((data.baseLine ? "Linea Base" : data.release))));
      }
    }
  }

  final _compareListController =
      StreamController<List<ComparationDB>>.broadcast();
  List<ComparationDB> _compareList;
  Stream<List<ComparationDB>> get compareList =>
      _compareListController.stream.asBroadcastStream();

  Future comparation(
      String schema, String idReleaseNuevo, String idReleaseAnterior) async {
    ApiResponse apiResponse = await _repository.getComparation(
        schema, idReleaseNuevo, idReleaseAnterior);
    if (apiResponse.statusResponse == 200) {
      _compareList = apiResponse.object;
      _compareListController.add(_compareList);
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  Future<bool> updateBaseLine(
      String schema, String releasenew, String releaseant) async {
    ApiResponse apiResponse =
        await _repository.updateBaseLine(schema, releasenew, releaseant);
    if (apiResponse.statusResponse == 200) {
      print(apiResponse.object);
      return true;
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
      return false;
    }
  }
}
