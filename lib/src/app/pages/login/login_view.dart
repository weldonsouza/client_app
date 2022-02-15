import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase/authentication.dart';
import '../address/address_view.dart';
import 'login_signup_view.dart';
import 'login_viewModel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static String get routeName => '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    Authentication.initializeFirebase(context: context);
  }

  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var loginController = Provider.of<LoginProviderController>(context);

    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image_background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
                  child: SvgPicture.asset(
                    'assets/logo_client_app.svg',
                    width: 300,
                  ),
                ),
                Column(
                  children: [
                    loginController.isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : CustomButton(
                            labelText: 'Entrar com Google',
                            width: 195,
                            height: 40,
                            borderRadius: 15,
                            elevation: 3,
                            color: Constants.primaryContainer,
                            colorText: Constants.primaryOnContainer,
                            colorButton: Constants.primaryContainer,
                            iconSvg: 'google',
                            iconSize: 20,
                            fontWeight: FontWeight.w700,
                            onTap: () async {
                              loginController.setIsLoading(true);

                              User? user = await authentication.signInWithGoogle(context: context);

                              loginController.setIsLoading(false);

                              if (user != null) {
                                loginController.authenticationGoogle(context);
                              }
                            }),
                    const SizedBox(height: 16),
                    CustomButton(
                      labelText: 'Entrar com Apple',
                      width: 195,
                      height: 40,
                      borderRadius: 15,
                      elevation: 3,
                      color: Constants.primaryContainer,
                      colorText: Constants.primaryOnContainer,
                      colorButton: Constants.primaryContainer,
                      iconSvg: 'apple',
                      iconSize: 20,
                      fontWeight: FontWeight.w700,
                      onTap: () => navigationService.push(LoginSignupView.routeName),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      labelText: 'Entrar como Visitante',
                      width: 195,
                      height: 40,
                      borderRadius: 15,
                      elevation: 3,
                      color: Constants.primaryContainer,
                      colorText: Constants.primaryOnContainer,
                      colorButton: Constants.primaryContainer,
                      textSize: 14,
                      fontWeight: FontWeight.w700,
                      iconData: Icons.person_outlined,
                      iconSize: 22,
                      onTap: () {
                        loginController.previousPage = 'address';
                        navigationService.push(AddressView.routeName);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
