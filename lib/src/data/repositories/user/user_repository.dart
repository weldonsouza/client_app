import 'package:client_app/src/data/datasources/user/user_remote.dart';
import 'package:client_app/src/domain/models/user/user_result.dart';

import '../../../domain/models/model_result.dart';
import '../../../domain/models/user/user_model.dart';

class UserRepository {
  UserRemote userRemote;

  UserRepository({required this.userRemote});

  Future<UserResult?> verifyClientByCpfAndBirthdate(String cpf, String birthdate) async {
    return await userRemote.verifyClientByCpfAndBirthdate(cpf, birthdate);
  }

  Future<int?> completeRegistration(UserModel userModel) async {
    return await userRemote.completeRegistration(userModel);
  }

  Future<ModelResult?> authenticationGoogle(String token) async {
    return await userRemote.authenticationGoogle(token);
  }
}
