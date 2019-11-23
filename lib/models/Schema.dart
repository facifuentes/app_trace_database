class Schema {
  String esquema;

  Schema(
      {this.esquema});

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
        esquema: json['esquema']
       );
  }
}