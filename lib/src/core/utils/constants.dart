import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String baseUrl = dotenv.env['URL']!;
  static String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxOWQyYTZmNTk3YjAzMTI4MzY2YmE2MCIsImVtYWlsIjoicm9iZXJ0b0BrdW5sYXRlay5jb20iLCJwcm9qZWN0cyI6W10sIm1vZHVsZXMiOltdLCJwZXJtaXNzaW9ucyI6W10sInBlcm1pc3Npb25Hcm91cHMiOltdLCJpYXQiOjE2NDQyNTEzODEsImV4cCI6MTY0NDMzNzc4MX0.VpbML6zn1gCrO-x8IRnnbE0jvI77-nMLrJ-wxk_upoc';
  static const String PRIVACY_POLICY_URL = 'https://www.google.com.br';
  static const String REGISTER_PROFESSIONAL_URL = 'https://www.google.com.br';
  static const String APPLE_STORE_URL = 'https://apps.apple.com/br/app/{nameApp}/{id}';
  static const String PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id={id}';

  static const MaterialColor customPrimaryColor = MaterialColor(
    0xFF8232C8,
    <int, Color>{
      50: Color(0xFFC8ACEB),
      100: Color(0xFFB586EB),
      200: Color(0xFFA561EB),
      300: Color(0xFF953BEB),
      400: Color(0xFF8637CC),
      500: Color(0xFF8232C8),
      600: Color(0xFF6F08C5),
      700: Color(0xFF5A009F),
      800: Color(0xFF460078),
      900: Color(0xFF320052),
    },
  );

  static const Color primaryColor = Color(0xff6850a4);
  static const Color primaryColor2 = Color(0xff8232C8);
  static const Color surface = Color(0xffFFFBFF);
  static const Color surface2 = Color(0xfff5ecfb);
  static const Color primaryContainer = Color(0xffF2DAFF);
  static const Color primaryOnContainer = Color(0xff2C0051);
  static const Color primaryContainerIcon = Color(0xff1F1F1F);

  static const Color successSnackBarColor = Color(0xff81ec78);
  static const Color errorSnackBarColor = Color(0xffFF0707);

  static const Color textField = Color(0xff7C757F);
  static const Color textFieldDisable = Color(0xffc9c9c9);
  static const Color primaryColor100 = Color(0xffF2DAFF);

  static const Color primaryColor50 = Color(0xffF2DAFF);
  static const Color primaryColor200 = Color(0xffF2DAFF);
  static const Color primaryColor500 = Color(0xff6850a4);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff1F1F1F);
  static const Color transparent = Color(0x00000000);
  static const Color appTextColor = Color(0xff9D9D9D);
  static const Color redColor = Color(0xFFF44336);
}
