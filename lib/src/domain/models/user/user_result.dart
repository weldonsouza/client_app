import 'people_model.dart';

class UserResult {
  bool? success;
  String? message;
  String? errorCode;
  PeopleModel? data;

  UserResult({this.success, this.message, this.errorCode, this.data});

  UserResult.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        errorCode = json['errorCode'] as String?,
        success = json['success'] as bool?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? PeopleModel.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'message': message,
        'errorCode': errorCode,
        'success': success,
        'data': data?.toJson()
      };
}
