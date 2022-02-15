import 'package:client_app/src/domain/models/address/address_model.dart';

class AddressResult {
  bool success;
  String message;
  String errorCode;
  AddressModel? data;

  AddressResult({required this.success, required this.message, required this.errorCode, this.data});

  AddressResult.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String,
        errorCode = json['errorCode'] as String,
        success = json['success'] as bool,
        data = (json['data'] as Map<String,dynamic>?) != null
            ? AddressModel.fromJson(json['data'] as Map<String,dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'errorCode' : errorCode,
    'success' : success,
    'data' : data?.toJson()
  };
}
