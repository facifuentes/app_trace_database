class ErrorApiResponse {
  int status;
  String timestamp;
  String error;
  String message;
  String path;
  ErrorApiResponse(
      {this.status, this.timestamp, this.error, this.message, this.path});
  factory ErrorApiResponse.fromJson(Map<String, dynamic> json) {
    return ErrorApiResponse(
        status: json['status'],
        timestamp: json['timestamp'],
        error: json['error'],
        message: json['message'],
        path: json['path']);
  }

  //Temporal mientras se corrige el endpoint
  factory ErrorApiResponse.fromJsonFiles(Map<String, dynamic> json) {
    return ErrorApiResponse(
        status: 500,
        message: json['data'],);
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'timestamp': timestamp,
        'error': error,
        'message': message,
        'path': path,
      };
}
