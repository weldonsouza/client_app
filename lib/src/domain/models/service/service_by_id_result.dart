import 'service_model.dart';

class ServiceByIdResult {
  bool? success;
  String? message;
  String? errorCode;
  ServiceModel? data;

  ServiceByIdResult({this.success, this.message, this.errorCode, this.data});

  ServiceByIdResult.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        errorCode = json['errorCode'] as String?,
        success = json['success'] as bool?,
        data = (json['data'] as Map<String,dynamic>?) != null
            ? ServiceModel.fromJson(json['data'] as Map<String,dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'errorCode' : errorCode,
    'success' : success,
    'data' : data?.toJson()
  };
}
