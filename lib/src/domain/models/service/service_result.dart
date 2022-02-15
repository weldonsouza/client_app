import 'services_model.dart';

class ServiceResult {
  bool? success;
  String? message;
  String? errorCode;
  ServicesModel? data;

  ServiceResult({this.success, this.message, this.errorCode, this.data});

  ServiceResult.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        errorCode = json['errorCode'] as String?,
        success = json['success'] as bool?,
        data = (json['data'] as Map<String,dynamic>?) != null
            ? ServicesModel.fromJson(json['data'] as Map<String,dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'errorCode' : errorCode,
    'success' : success,
    'data' : data?.toJson()
  };
}
