import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trace_database/models/ComparationDB.dart';
import 'package:trace_database/models/ReleaseDB.dart';
import 'package:trace_database/models/ReleaseSchema.dart';
import 'package:trace_database/models/apiresponse_model.dart';
import 'package:trace_database/repository/repository.dart';

class DataBLOC {
  final _repository = Repository();
  var _apiResponse = ApiResponse();
  String _idRelease = "";

  DataBLOC();
 

  final _reschemaListController =
      StreamController<List<ReleaseSchema>>.broadcast();
  List<ReleaseSchema> _releaseSchemalList;
  List<ReleaseSchema> get releasesScheme => _releaseSchemalList;
  Stream<List<ReleaseSchema>> get reschemaList =>
      _reschemaListController.stream.asBroadcastStream();

  Future getAllDataReleasesbySchema(String schema) async {
    ApiResponse apiResponse = await _repository.getAllDataReleasesbySchema(schema);
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

  Future getDataRelease(String idRelease) async {
    _idRelease = idRelease;
    ApiResponse apiResponse = await _repository.getDataRelease(idRelease);
    if (apiResponse.statusResponse == 200) {
      _releaselList = apiResponse.object;
      _getReleaseListController.add(_releaselList);
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  Future<bool> createDataReleaseDB(String schema) async {
    ApiResponse apiResponse = await _repository.createDataReleaseDB(schema);
    if (apiResponse.statusResponse == 200) {
      //_releaseSchemalList = apiResponse.object;
      getAllDataReleasesbySchema(schema);
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

  Future getDataComparation(
      String schema, String idReleaseNuevo, String idReleaseAnterior) async {
    ApiResponse apiResponse = await _repository.getDataComparation(
        schema, idReleaseNuevo, idReleaseAnterior);
    if (apiResponse.statusResponse == 200) {
      _compareList = apiResponse.object;
      _compareListController.add(_compareList);
    } else {
      _apiResponse = apiResponse;
      print(_apiResponse);
    }
  }

  Future<bool> updateDataBaseLine(
      String schema, String releasenew, String releaseant) async {
    ApiResponse apiResponse =
        await _repository.updateDataBaseLine(schema, releasenew, releaseant);
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
