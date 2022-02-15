import 'package:client_app/src/core/provider/global_providers.dart';

class CallUtils {
  final userLocal = setupLocator.serviceLocatorUserLocal;

  Future<String?> createGetHeader() async {
    return await userLocal.getAuthToken();
  }
}