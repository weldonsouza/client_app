import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client_app/src/core/provider/global_providers.dart';

import '../route/navigation_service.dart';

final Authentication authentication = Authentication();

class Authentication {
  final _userEntity = setupLocator.serviceLocatorUserEntity;

  // Auto login
  static Future<FirebaseApp> initializeFirebase({required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //navigationService.push(BottomNavigationBarController.routeName);

      /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            user: user,
          ),
        ),
      );*/
    }

    return firebaseApp;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        NavigationService.showSnackbarMessage('Aconteceu um erro inesperado, tente novamente mais tarde!', false);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);

          user = userCredential.user;
          await _userEntity.saveAuthTokenGoogle(googleSignInAuthentication.accessToken!);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            NavigationService.showSnackbarMessage('A conta já existe com uma credencial diferente', false);
          } else if (e.code == 'invalid-credential') {
            NavigationService.showSnackbarMessage('Ocorreu um erro ao acessar as credenciais. Tente novamente.', false);
          }
        } catch (e) {
          NavigationService.showSnackbarMessage('Ocorreu um erro ao usar o Login do Google. Tente novamente.', false);
        }
      }
    }

    return user;
  }

  // Logout account google
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      NavigationService.showSnackbarMessage('Erro ao sair. Tente novamente.', false);
    }
  }
}
