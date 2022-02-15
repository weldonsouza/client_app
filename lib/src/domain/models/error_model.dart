class ErrorModel {
  String? message;
  String? errorCode;
  bool? success;
  dynamic data;

  ErrorModel({
    this.message,
    this.errorCode,
    this.success,
    this.data,
  });

  ErrorModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        errorCode = json['errorCode'],
        success = json['success'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'errorCode': errorCode,
        'success': success,
        'data': data,
      };
}
