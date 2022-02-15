import 'package:flutter/material.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';

import 'custom_button.dart';
import 'custom_text_field.dart';

class CustomAlertService {
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String warning,
    required String labelText,
    required TextEditingController textController,
    required var textValue,
    required var textOnChange,
    IconData? iconData,
    Function()? onTap,
  }) async {
    textController.text = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants.primaryColor100,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Constants.redColor,
              ),
              Container(
                width: Utils.mediaQuery(context, 0.9),
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Constants.blackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              CustomTextFormField(
                controller: textController,
                labelText: labelText,
                value: textValue,
                onChange: (value) => textOnChange(value),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  warning,
                  style: const TextStyle(
                    color: Constants.blackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  labelText: 'Enviar',
                  width: 60,
                  height: 30,
                  borderRadius: 4,
                  elevation: 0,
                  textSize: 12,
                  iconSize: 22,
                  paddingButton: 8,
                  color: Constants.transparent,
                  colorText: Constants.primaryColor500,
                  colorButton: Constants.transparent,
                  onTap: onTap,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
