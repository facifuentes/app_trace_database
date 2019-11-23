import 'package:trace_database/models/ComparationDB.dart';
import 'package:trace_database/models/ReleaseDB.dart';
import 'package:trace_database/models/ReleaseSchema.dart';
import 'package:trace_database/models/Schema.dart';
import 'package:trace_database/models/apiresponse_model.dart';
import 'package:trace_database/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SchemaApiService {
  SchemaApiService();

  Future<ApiResponse> getAllSchema() async {
    List<Schema> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url =
        Uri.http(Constants.urlAuthority, Constants.pathBase + "/getAllSchema");
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(Schema.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> getAllReleasesbySchema(String schema) async {
    List<ReleaseSchema> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/getAllReleasesbySchema/" + schema);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseSchema.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> getRelease(String schema, String idRelease) async {
    List<ReleaseDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/getRelease/" + schema + "/" + idRelease);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> createReleaseDB(String schema) async {
    List<ReleaseDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/createReleaseDB/" + schema);
    var res = await http.post(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> getComparation(
      String schema, String idReleasenuevo, String idReleaseAnterior) async {
    List<ComparationDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(
        Constants.urlAuthority,
        Constants.pathBase +
            "/getComparation/" +
            schema +
            "/" +
            idReleasenuevo +
            "/" +
            idReleaseAnterior);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ComparationDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> updateBaseLine(
      String schema, String releasenew, String releaseant) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(
        Constants.urlAuthority,
        Constants.pathBase +
            "/updateBaseLine/" +
            schema +
            "/" +
            releasenew +
            "/" +
            releaseant);
    var res = await http.put(url);
    //var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      apiResponse.object = "Linea Base actualizada!!";
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

//Parametros de configuración


Future<ApiResponse> getAllDataReleasesbySchema(String schema) async {
    List<ReleaseSchema> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/getAllDataReleasesbySchema/" + schema);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseSchema.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> getDataRelease(String idRelease) async {
    List<ReleaseDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/getReleaseData/"+ idRelease);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> createDataReleaseDB(String schema) async {
    List<ReleaseDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority,
        Constants.pathBase + "/createReleaseData/" + schema);
    var res = await http.post(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ReleaseDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> getDataComparation(
      String schema, String idReleasenuevo, String idReleaseAnterior) async {
    List<ComparationDB> listSchema = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(
        Constants.urlAuthority,
        Constants.pathBase +
            "/getComparationData/" +
            schema +
            "/" +
            idReleasenuevo +
            "/" +
            idReleaseAnterior);
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listSchema = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listSchema.add(ComparationDB.fromJson(i));
        return i;
      });
      apiResponse.object = listSchema;
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

  Future<ApiResponse> updateDataBaseLine(
      String schema, String releasenew, String releaseant) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(
        Constants.urlAuthority,
        Constants.pathBase +
            "/updateDataBaseLine/" +
            schema +
            "/" +
            releasenew +
            "/" +
            releaseant);
    var res = await http.put(url);
    //var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      apiResponse.object = "Linea Base actualizada!!";
    } else {
      apiResponse.object = "Error";
    }

    return apiResponse;
  }

}
