import 'package:trace_database/models/apiresponse_model.dart';
import 'package:trace_database/repository/Schema_Api_Service.dart';

class Repository {
  final schemaApiService = SchemaApiService();
  Future<ApiResponse> getAllSchemas() => schemaApiService.getAllSchema();
  Future<ApiResponse> getAllReleasesbySchema(String schema) =>
      schemaApiService.getAllReleasesbySchema(schema);
  Future<ApiResponse> getRelease(String schema, String idReleases) =>
      schemaApiService.getRelease(schema, idReleases);
  Future<ApiResponse> createReleaseDB(String schema) =>
      schemaApiService.createReleaseDB(schema);
  Future<ApiResponse> getComparation(
          String schema, String idReleases1, String idRelease22) =>
      schemaApiService.getComparation(schema, idReleases1, idRelease22);
  Future<ApiResponse> updateBaseLine(
          String schema, String releasenew, String releaseant) =>
      schemaApiService.updateBaseLine(schema, releasenew, releaseant);

  //Parametros de configuración
   Future<ApiResponse> getAllDataReleasesbySchema(String schema) =>
      schemaApiService.getAllDataReleasesbySchema(schema);
  Future<ApiResponse> getDataRelease( String idReleases) =>
      schemaApiService.getDataRelease( idReleases);
  Future<ApiResponse> createDataReleaseDB(String schema) =>
      schemaApiService.createDataReleaseDB(schema);
  Future<ApiResponse> getDataComparation(
          String schema, String idReleases1, String idRelease22) =>
      schemaApiService.getDataComparation(schema, idReleases1, idRelease22);
  Future<ApiResponse> updateDataBaseLine(
          String schema, String releasenew, String releaseant) =>
      schemaApiService.updateDataBaseLine(schema, releasenew, releaseant);
}
