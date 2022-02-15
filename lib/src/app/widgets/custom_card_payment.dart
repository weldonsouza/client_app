import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';

class CustomCardPayment extends StatelessWidget {
  final String title;
  final String subTitle;
  final String titleButton;
  String assetName;
  Function()? onTap;
  double widthButton;
  double heightButton;

  CustomCardPayment({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.titleButton,
    required this.assetName,
    this.onTap,
    this.widthButton = 85,
    this.heightButton = 22,
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
        padding: const EdgeInsets.only(top: 8, left: 4, right: 0, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 15),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Constants.primaryColor2,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        assetName,
                        width: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 230,
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
                      subTitle.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                subTitle,
                                style: GoogleFonts.raleway(
                                  color: Constants.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Constants.primaryColor2,
              ),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
