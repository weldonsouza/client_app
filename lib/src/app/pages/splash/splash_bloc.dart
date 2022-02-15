import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client_app/src/core/route/navigation_service.dart';

import '../login/login_view.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required this.animationController,
  }) : super(const SplashState()) {
    _init();
  }

  final AnimationController animationController;
  Animation<double>? fadeAnimation;

  Future<void> _init() async {
    fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await navigationService.pushReplacement(LoginView.routeName);
      }
    });

    await animationController.forward();
  }

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    //
  }
}
