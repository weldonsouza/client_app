import 'package:client_app/src/data/datasources/network/client_app_api_service.dart';
import 'package:client_app/src/domain/models/user/user_result.dart';

import '../../../domain/models/model_result.dart';
import '../../../domain/models/user/user_model.dart';
import '../local/call_utils.dart';

class UserRemote {
  ClientAppApiService clientAppApiService;

  UserRemote({required this.clientAppApiService});

  Future<UserResult?> verifyClientByCpfAndBirthdate(String cpf, String birthdate) async {
    try {
      final signUpBody = {"cpf": cpf, "birthday": birthdate};
      var createGetHeader = await CallUtils().createGetHeader();
      final response = await clientAppApiService.verifyClientByCpfAndBirthdate(signUpBody, createGetHeader!);

      return response.body;
    } catch (e) {
      return null;
    }
  }

  Future<int?> completeRegistration(UserModel userModel) async {
    try {
      var createGetHeader = await CallUtils().createGetHeader();
      final response = await clientAppApiService.completeRegistration(userModel, createGetHeader!);

      return response.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<ModelResult?> authenticationGoogle(String token) async {
    try {
      final response = await clientAppApiService.authenticationGoogle(token.toString());

      return response.body;
    } catch (e) {
      return null;
    }
  }
}