import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';

import 'custom_button.dart';

class CustomAlertSignUp {
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String warning,
    IconData? iconData,
    Function()? onTapToAgree,
    Function()? onTapExit,
  }) async {
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
                color: Constants.blackColor,
              ),
              Container(
                width: Utils.mediaQuery(context, 0.9),
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Constants.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '$warning\n',
                  style: GoogleFonts.raleway(
                    color: Constants.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Termos',
                      style: GoogleFonts.raleway(
                        color: Constants.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.PRIVACY_POLICY_URL);
                        },
                    ),
                    TextSpan(
                      text: ' e ',
                      style: GoogleFonts.raleway(
                        color: Constants.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'Politica de Privacidade.',
                      style: GoogleFonts.raleway(
                        color: Constants.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.PRIVACY_POLICY_URL);
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
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
                  labelText: 'Sair',
                  width: 70,
                  height: 30,
                  borderRadius: 50,
                  elevation: 0,
                  textSize: 14,
                  iconSize: 22,
                  paddingButton: 8,
                  fontWeight: FontWeight.w700,
                  color: Constants.transparent,
                  colorText: Constants.primaryColor2,
                  colorButton: Constants.blackColor,
                  onTap: onTapExit,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  labelText: 'Concordar',
                  width: 100,
                  height: 30,
                  borderRadius: 50,
                  elevation: 0,
                  textSize: 14,
                  iconSize: 22,
                  paddingButton: 8,
                  fontWeight: FontWeight.w700,
                  color: Constants.primaryColor,
                  colorText: Constants.whiteColor,
                  colorButton: Constants.transparent,
                  onTap: onTapToAgree,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
