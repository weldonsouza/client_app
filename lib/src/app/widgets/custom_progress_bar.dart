import 'package:flutter/material.dart';
import 'package:client_app/src/core/utils/constants.dart';

class CustomProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final double height;
  final Color color;

  const CustomProgressBar({
    Key? key,
    required this.max,
    required this.current,
    this.color = Constants.primaryColor,
    this.height = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 10,
              decoration: BoxDecoration(
                color: Constants.primaryContainer,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
