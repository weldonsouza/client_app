import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:flutter/material.dart';

class AlertService {
  static Future<void> showAlert({
    String title = 'Alerta',
    required String message,
  }) async {
    final context = NavigationService.navigationKey.currentContext;
    if (context != null) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  static Future<bool?> showOptions({
    // required BuildContext context,
    required String message,
    String title = 'Alerta',
    String denial = 'NÃO',
    String accept = 'SIM',
  }) async {
    final context = NavigationService.navigationKey.currentContext;
    if (context != null) {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(denial),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(accept),
            ),
          ],
        ),
      );
    }
  }
}
