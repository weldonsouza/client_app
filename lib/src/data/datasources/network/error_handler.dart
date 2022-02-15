import 'package:client_app/src/core/route/navigation_service.dart';

class ErrorHandler {
  static void handleResponseError(int? statusCode, String? message, String? errorCode) {
    if (statusCode != null) {
      if (message!.isEmpty) statusCode = -1;

      switch (statusCode) {
        case -1:
          NavigationService.showSnackbarMessage(message, false);
          break;
        case 400:
          NavigationService.showSnackbarMessage(message, false);
          break;
        case 401:
          NavigationService.showSnackbarMessage('usuario não autorizado!', false);
          break;
        default:
          break;
      }
    } else {
      NavigationService.showSnackbarMessage('Aconteceu um erro inesperado, tente novamente mais tarde!', false);
    }
  }
}
