import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/data/repositories/user/user_repository.dart';
import 'package:client_app/src/domain/models/user/user_result.dart';

import '../models/model_result.dart';
import '../models/user/user_model.dart';

class UserEntity {
  UserRepository userRepository;
  final userLocal = setupLocator.serviceLocatorUserLocal;

  UserEntity({required this.userRepository});

  Future<UserModel?> executeClientByCpfAndBirthdate(String cpf, String birthdate) async {
    UserResult? userResult = await userRepository.verifyClientByCpfAndBirthdate(cpf, birthdate);

    if (userResult != null) {
      return userResult.data!.people;
    }
    return null;
  }

  Future<int?> executeCompleteRegistration(UserModel userModel) async {
    int? userResult = await userRepository.completeRegistration(userModel);

    if (userResult == 200 || userResult == 201) {
      return userResult;
    }
    return null;
  }

  Future<ModelResult?> executeAuthenticationGoogle(String token) async {
    ModelResult? userResult = await userRepository.authenticationGoogle(token);

    if (userResult != null) {
      return userResult;
    }
    return null;
  }

  Future<void> saveAuthToken(String token) async {
    await userLocal.saveAuthToken(token);
  }

  Future<void> saveAuthTokenGoogle(String token) async {
    await userLocal.saveAuthTokenGoogle(token);
  }

  Future<String?> getAuthTokenGoogle() async {
    return await userLocal.getAuthTokenGoogle();
  }

  Future<void> logout() async {
    await userLocal.logout();
  }
}