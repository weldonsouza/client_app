import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

var formatFraction = NumberFormat("#,##0.00", "pt_BR");

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
  SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
}

class Utils {
  static mediaQuery(BuildContext context, double value, {String? direction}) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    direction = direction ?? 'H'; //Used to define the calculation direction
    Size size = mediaQuery.size;
    if (direction.toUpperCase() == 'H') {
      return size.width * value;
    }
    return size.height * value;
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static String? dateStringToDate(String stringdate) {
    String? _stringdate;

    List<String> validadeSplit = stringdate.split('/');

    if (validadeSplit.length > 1) {
      int day = int.parse(validadeSplit[0].toString());
      int month = int.parse(validadeSplit[1].toString());
      int year = int.parse(validadeSplit[2].toString());

      _stringdate = '$year-$month-$day';
    }

    return _stringdate;
  }
}
