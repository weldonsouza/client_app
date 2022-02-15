import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/app/pages/address/address_viewModel.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/domain/models/service/service_model.dart';
import 'package:provider/src/provider.dart';

import 'service_viewModel.dart';

class ServiceView extends StatefulWidget {
  final ServiceModel? service;

  const ServiceView({Key? key, required this.service}) : super(key: key);

  static String get routeName => '/service';

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ServiceProviderController>().init(
            widget.service!.id,
            context.read<AddressProviderController>().addressModelResult.cityId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var serviceController = Provider.of<ServiceProviderController>(context);

    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Constants.blackColor),
        title: Text(
          '${widget.service!.name}',
          style: GoogleFonts.raleway(
            color: Constants.blackColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: serviceController.isLoading
          ? Container(
              width: MediaQuery.of(context).size.width,
              color: Constants.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Constants.blackColor,
                      ),
                    ),
                  ),
                  Text(
                    'Aguarde...',
                    style: GoogleFonts.raleway(
                      color: Constants.blackColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        carouselController: controllerCarouselSlider,
                        items: serviceController.service.images!.map((item) => ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 5,
                                      color: Constants.whiteColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          imageUrl: item,
                                          width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Image.asset(
                                            'assets/image_not_found.png',
                                            fit: BoxFit.cover,
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
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () => controllerCarouselSlider.previousPage(),
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              size: 16,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => controllerCarouselSlider.nextPage(),
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ).toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          height: 280,
                          viewportFraction: 1,
                          scrollDirection: Axis.horizontal,
                          disableCenter: false,
                          reverse: false,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Text(
                          '${serviceController.service.description}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                            color: Constants.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15, bottom: 15),
                              child: Row(
                                children: [
                                  const Icon(Icons.alarm_outlined),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${serviceController.service.minimumDuration} a '
                                    '${serviceController.service.maximumDuration} minutos',
                                    style: GoogleFonts.raleway(
                                      color: Constants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.warning),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Contra-indicações',
                                      style: GoogleFonts.raleway(
                                        color: Constants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  titleExpandedContraIndication
                                      ? Icons.arrow_drop_up_outlined
                                      : Icons.arrow_drop_down,
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${serviceController.service.contraIndication}',
                                          style: GoogleFonts.raleway(
                                            color: Constants.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onExpansionChanged: (bool expanded) {
                                  setState(() {
                                    titleExpandedContraIndication = expanded;
                                    titleExpandedHowToPrepare = false;
                                  });
                                },
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.assignment),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Como se preparar',
                                      style: GoogleFonts.raleway(
                                        color: Constants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  titleExpandedHowToPrepare
                                      ? Icons.arrow_drop_up_outlined
                                      : Icons.arrow_drop_down,
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${serviceController.service.howToPrepare}',
                                          style: GoogleFonts.raleway(
                                            color: Constants.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onExpansionChanged: (bool expanded) {
                                  setState(() {
                                    titleExpandedHowToPrepare = expanded;
                                    titleExpandedContraIndication = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: CustomButton(
                            labelText: serviceController.getPriceService,
                            width: 160,
                            height: 30,
                            borderRadius: 10,
                            elevation: 3,
                            textSize: 12,
                            iconSize: 22,
                            paddingButton: 8,
                            color: Constants.primaryContainer,
                            colorText: Constants.blackColor,
                            colorButton: Constants.primaryContainer,
                            iconData: Icons.today,
                            onTap: () async {
                              serviceController.selectDatePicker(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
