
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:client_app/src/core/utils/constants.dart';

class ListPromotionalBanner extends StatefulWidget {
  final List<dynamic>? listBanners;

  const ListPromotionalBanner({
    Key? key,
    this.listBanners,
  }) : super(key: key);

  @override
  _ListPromotionalBannerState createState() => _ListPromotionalBannerState();
}

class _ListPromotionalBannerState extends State<ListPromotionalBanner> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 300,
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 4,
              color: Constants.primaryColor50,
              margin: const EdgeInsets.only(left: 12),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: widget.listBanners![0],
                  width: double.infinity,
                  height: 80,
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
            ),
          ),
        );
      },
      itemCount: widget.listBanners!.isNotEmpty ? widget.listBanners!.length : 0,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
    );
  }
}