import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';

import 'custom_button.dart';

class CustomCardService extends StatelessWidget {
  final String title;
  final String subTitle;
  final String titleButton;
  IconData? iconData;
  IconData? iconDataButton;
  Function()? onTap;
  double widthButton;
  double heightButton;
  bool visible;

  CustomCardService({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.titleButton,
    this.iconData,
    this.iconDataButton,
    this.onTap,
    this.widthButton = 80,
    this.heightButton = 22,
    this.visible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Constants.surface,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 12),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 35,
                      height: 35,
                      color: Constants.primaryColor2,
                      alignment: Alignment.center,
                      child: Icon(
                        iconData,
                        color: Constants.whiteColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 165,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.raleway(
                          color: Constants.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subTitle.isNotEmpty ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          subTitle,
                          overflow: title == 'Observações' ? TextOverflow.ellipsis : null,
                          style: GoogleFonts.raleway(
                            color: Constants.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
              ],
            ),
            visible == false
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(2),
                    child: CustomButton(
                      labelText: titleButton,
                      width: widthButton,
                      height: heightButton,
                      borderRadius: 50,
                      elevation: 0,
                      textSize: 14,
                      iconSize: 18,
                      paddingButton: 8,
                      color: Constants.primaryColor2,
                      colorText: Constants.whiteColor,
                      colorButton: Constants.whiteColor,
                      iconData: iconDataButton,
                      onTap: onTap,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
