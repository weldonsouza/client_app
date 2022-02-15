import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/domain/models/service/items_model.dart';

import 'list_items_services_widget.dart';

// ignore: must_be_immutable
class ListServices extends StatefulWidget {
  final List<Items> listServices;

  const ListServices({
    Key? key,
    required this.listServices,
  }) : super(key: key);

  @override
  _ListServicesState createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20, left: 10, bottom: 4),
              child: Text(
                '${widget.listServices[index].name}',
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Constants.blackColor,
                ),
              ),
            ),
            widget.listServices.isNotEmpty
                ? SizedBox(
                    width: double.infinity,
                    child: ListItemsServicesWidget(
                      listOfServices: widget.listServices[index].services!,
                    ),
                  )
                : Container(),
          ],
        );
      },
      itemCount:
          widget.listServices.isNotEmpty ? widget.listServices.length : 0,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}
