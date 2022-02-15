import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_bloc.dart';
import 'splash_view.dart';

class SplashPage extends StatefulWidget {
  static String get routeName => '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        animationController: AnimationController(
          duration: const Duration(milliseconds: 1800),
          vsync: this,
        ),
      ),
      child: SplashView(),
    );
  }
}
