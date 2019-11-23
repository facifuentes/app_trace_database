class ApiResponse {
  int statusResponse;
  String message;
  Object object;
  ApiResponse({this.statusResponse, this.object,this.message});
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        statusResponse: json['statusResponse'],
        object: json['object']);
  }

  Map<String, dynamic> toJson() => {
        'statusResponse': statusResponse,
        'object': object
      };
}
