class ModelResult {
  int? statusCode;
  String? message;
  String? errorCode;
  bool? success;
  dynamic data;

  ModelResult({
    this.statusCode,
    this.message,
    this.errorCode,
    this.success,
    this.data,
  });

  ModelResult.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'],
        message = json['message'],
        errorCode = json['errorCode'],
        success = json['success'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'errorCode': errorCode,
        'success': success,
        'data': data,
      };
}
