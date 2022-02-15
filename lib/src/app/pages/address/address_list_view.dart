import 'package:flutter/material.dart';
import 'package:client_app/src/core/utils/constants.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({Key? key}) : super(key: key);

  static String get routeName => '/addresslist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor50,
        elevation: 0,
        iconTheme: const IconThemeData(color: Constants.blackColor),
        title: const Text(
          'Meus endereços',
          style: TextStyle(
            color: Constants.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
