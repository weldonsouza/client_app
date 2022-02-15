import 'package:flutter/material.dart';
import 'package:client_app/src/domain/models/service/service_model.dart';

import 'item_widget.dart';

class ListItemsServicesWidget extends StatelessWidget {
  final List<ServiceModel> listOfServices;

  const ListItemsServicesWidget({Key? key, required this.listOfServices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: listOfServices.isNotEmpty ? listOfServices.length : 0,
        itemBuilder: (context, index) {
          return ItemWidget(
            service: listOfServices[index],
          );
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}
