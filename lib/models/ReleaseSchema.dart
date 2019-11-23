class ReleaseSchema {
  String esquema;
  String release;
  String fecha;
  bool baseLine;

  ReleaseSchema({this.esquema, this.release, this.fecha, this.baseLine});

  factory ReleaseSchema.fromJson(Map<String, dynamic> json) {
    return ReleaseSchema(
        esquema: json['esquema'],
        release: json['release'],
        fecha: json['fecha'],
        baseLine: json['lineaBase']);
  }
}
