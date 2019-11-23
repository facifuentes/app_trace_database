class ComparationDB {
  String releasenuevo;
  String camponuevo;
  String estructuranueva;
  String huellanueva;
  String releaseanterior;
  String estructuraanterior;
  String huellaanterior;
  String estado;

  ComparationDB(
      {this.camponuevo,
      this.estado,
      this.estructuraanterior,
      this.estructuranueva,
      this.huellaanterior,
      this.huellanueva,
      this.releaseanterior,
      this.releasenuevo});



  factory ComparationDB.fromJson(Map<String, dynamic> json) {
   
    return ComparationDB(
        camponuevo: json['camponuevo'],
        estado: json['estado'],
        estructuraanterior: json['estructuraanterior'],
        estructuranueva: json['estructuranueva'],
        huellaanterior: json['huellaanterior'],
        huellanueva: json['huellanueva'],
        releaseanterior: json['releaseanterior'],
        releasenuevo: json['releasenuevo']);
  }
}
