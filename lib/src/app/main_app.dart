import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:client_app/src/core/provider/provider_setup.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:provider/provider.dart';

import '../core/route/navigation_service.dart';
import 'pages/address/address_list_view.dart';
import 'pages/address/address_view.dart';
import 'pages/home/home_view.dart';
import 'pages/login/login_signup_view.dart';
import 'pages/login/login_view.dart';
import 'pages/main/buttom_navigation_bar_controller.dart';
import 'pages/my_requests/my_requests_view.dart';
import 'pages/schedule_service/schedule_service_view.dart';
import 'pages/splash/splash_page.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'client_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Constants.primaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Constants.customPrimaryColor,
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        navigatorKey: NavigationService.navigationKey,
        home: SplashPage(),
        routes: {
          BottomNavigationBarController.routeName: (BuildContext context) => const BottomNavigationBarController(),
          AddressView.routeName: (BuildContext context) => const AddressView(),
          AddressListView.routeName: (BuildContext context) => const AddressListView(),
          SplashPage.routeName: (BuildContext context) => SplashPage(),
          LoginView.routeName: (BuildContext context) => const LoginView(),
          LoginSignupView.routeName: (BuildContext context) => const LoginSignupView(),
          HomeView.routeName: (BuildContext context) => const HomeView(),
          ScheduleServiceView.routeName: (BuildContext context) => const ScheduleServiceView(),
          MyRequestsView.routeName: (BuildContext context) => const MyRequestsView(),
        },
      ),
    );
  }
}
