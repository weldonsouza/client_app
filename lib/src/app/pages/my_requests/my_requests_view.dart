import 'package:flutter/material.dart';

import '../../../core/firebase/authentication.dart';
import '../../../core/utils/constants.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({Key? key}) : super(key: key);

  static String get routeName => '/my_requests';

  @override
  _MyRequestsViewState createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.surface,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.redAccent,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () async => await Authentication.signOut(context: context),
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
