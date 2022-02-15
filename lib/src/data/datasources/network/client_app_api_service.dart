import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/domain/models/address/address_result.dart';
import 'package:client_app/src/domain/models/model_result.dart';
import 'package:client_app/src/domain/models/service/service_by_id_result.dart';
import 'package:client_app/src/domain/models/service/service_result.dart';
import 'package:client_app/src/domain/models/user/user_result.dart';

import 'mobile_data_interceptor.dart';

part 'client_app_api_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class ClientAppApiService extends ChopperService {

  // Address
  Future<Response<AddressResult>> findAddressByZipcode(String zipCode) {
    final $url = '/address/zipcode/$zipCode';
    final $request = Request('GET', $url, Constants.baseUrl);
    return client.send<AddressResult, AddressResult>($request);
  }

  // User
  Future<Response<UserResult>> verifyClientByCpfAndBirthdate(parameters, String headers) {
    const $url = '/user/verify-client-by-cpf-and-birthdate';
    final $headers = {'Authorization': headers};
    final $parameters = parameters;
    final $request = Request('GET', $url, Constants.baseUrl, headers: $headers, parameters: $parameters);
    return client.send<UserResult, UserResult>($request);
  }

  Future<Response<ModelResult>> completeRegistration(body, String headers) {
    const $url = '/user/complete-registration';
    final $headers = {'Authorization': headers};
    final $body = body;
    final $request = Request('POST', $url, Constants.baseUrl, headers: $headers, body: $body);
    return client.send<ModelResult, ModelResult>($request);
  }

  Future<Response<ModelResult>> authenticationGoogle(String token) {
    final $url = '/user/authentication/google/$token';
    final $request = Request('POST', $url, Constants.baseUrl);
    return client.send<ModelResult, ModelResult>($request);
  }

  static ClientAppApiService create([ChopperClient? client]) => _$ClientAppApiService(client);
}

class ClientAppClient {
  final ChopperClient chopperClient;

  ClientAppClient()
      : chopperClient = ChopperClient(
          baseUrl: Constants.baseUrl,
          services: [
            _$ClientAppApiService(),
          ],
          interceptors: [
            MobileDataInterceptor(),
            HttpLoggingInterceptor(),
            const HeadersInterceptor({'Cache-Control': 'no-cache'}),
            const HeadersInterceptor({'Content-Type': 'application/json'})
          ],
          converter: JsonToTypeConverter(
            {
              AddressResult: (jsonData) => AddressResult.fromJson(jsonData),
              ServiceResult: (jsonData) => ServiceResult.fromJson(jsonData),
              ServiceByIdResult: (jsonData) => ServiceByIdResult.fromJson(jsonData),
              ModelResult: (jsonData) => ModelResult.fromJson(jsonData),
              UserResult: (jsonData) => UserResult.fromJson(jsonData),
            },
          ),
        );
}

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  const JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(response.body, typeToJsonFactoryMap[InnerType]!),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}
