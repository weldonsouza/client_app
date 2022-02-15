import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:client_app/src/domain/models/error_model.dart';

import 'error_handler.dart';

class MobileDataInterceptor implements RequestInterceptor, ResponseInterceptor {
  static const int SUCCESS_CODE = 200;

  @override
  FutureOr<Request> onRequest(Request request) async {
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    try {
      if (!response.isSuccessful) {
        ErrorModel e;
        Map<String, dynamic> map = jsonDecode(response.error.toString());
        e = ErrorModel.fromJson(map);
        ErrorHandler.handleResponseError(response.statusCode, e.message, e.errorCode);
      }
    } on Exception {
      ErrorHandler.handleResponseError(response.statusCode, response.error.toString(), '');
    }
    return response;
  }
}
