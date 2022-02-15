import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Color color;
  final Color colorText;
  final Color colorButton;
  Function()? onTap;
  String? iconSvg;
  IconData? iconData;
  final double width;
  final double height;
  final double elevation;
  final double borderRadius;
  final double textSize;
  final double iconSize;
  final double paddingButton;
  final FontWeight fontWeight;

  CustomButton({
    Key? key,
    this.labelText = '',
    this.color = Constants.primaryContainer,
    this.colorText = Constants.blackColor,
    this.colorButton = Constants.primaryColor,
    this.onTap,
    this.iconSvg,
    this.iconData,
    required this.width,
    this.height = 40,
    this.elevation = 0,
    this.borderRadius = 0,
    this.textSize = 14,
    this.iconSize = 28,
    this.paddingButton = 5,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
              return EdgeInsets.all(paddingButton);
            },
          ),
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return color; // Disabled color
            }
            return color; // Regular color
          }),
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.pressed)
                ? Colors.grey.shade100
                : colorButton;
            return BorderSide(color: color, width: 1);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconSvg != null
                  ? Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset(
                        'assets/$iconSvg.svg',
                        width: iconSize,
                      ),
                  )
                  : Container(),
              iconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        iconData,
                        color: colorText,
                        size: iconSize,
                      ),
                    )
                  : Container(),
              Text(
                labelText,
                style: GoogleFonts.raleway(
                  color: colorText,
                  fontSize: textSize,
                  fontWeight: fontWeight
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
