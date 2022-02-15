import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_bloc.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const containerWidth = 244.0;
    return Scaffold(
      body: Center(
        child: Container(
          width: containerWidth,
          height: 97,
          child: Stack(
            children: [
              Positioned.fill(
                child: ScaleTransition(
                  scale: context.read<SplashBloc>().fadeAnimation!,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: FittedBox(
                      child: Text(
                        'client_app',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
