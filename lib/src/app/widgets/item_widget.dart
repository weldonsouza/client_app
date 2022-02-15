import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:client_app/src/domain/models/service/service_model.dart';

import '../pages/service/service_view.dart';

class ItemWidget extends StatelessWidget {
  final ServiceModel service;

  const ItemWidget({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceView(service: service)),
      ),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 4,
          color: Constants.surface,
          margin: const EdgeInsets.only(left: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: service.images![0],
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/image_not_found.png',
                  ),
                  placeholder: (context, url) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${service.name}',
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Constants.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'R\$${formatFraction.format(service.price)}',
                            style: GoogleFonts.raleway(
                              color: Constants.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
