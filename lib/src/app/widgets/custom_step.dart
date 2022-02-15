import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';

class CustomStep extends StatelessWidget {
  final String stepTitle;
  final String textInfo;
  final String? subtitle;

  const CustomStep({
    Key? key,
    required this.stepTitle,
    required this.textInfo,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            stepTitle,
            style: GoogleFonts.raleway(
              color: Constants.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            textInfo,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: Constants.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        subtitle != null
            ? Container(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
