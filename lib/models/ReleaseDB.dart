class ReleaseDB {
  String id;
  String release;
  String campo;
  String estructura;
  String huella;
  String fecha;
  bool baseLine;

  ReleaseDB(
      {this.campo,
      this.estructura,
      this.fecha,
      this.huella,
      this.id,
      this.release,
      this.baseLine});

  factory ReleaseDB.fromJson(Map<String, dynamic> json) {
    return ReleaseDB(
        campo: json['r_campo'],
        estructura: json['r_estructura'],
        huella: json['r_huella'],
        fecha: json['r_fecha'],
        id: json['r_id'].toString(),
        release: json['r_release'],
        baseLine: json['r_lineaBase']);
  }
}
