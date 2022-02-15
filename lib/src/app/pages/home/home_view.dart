import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/app/widgets/list_promotional_banner.dart';
import 'package:client_app/src/app/widgets/list_services.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:provider/provider.dart';

import '../address/address_view.dart';
import 'home_viewModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static String get routeName => '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Provider.of<HomeProviderController>(context, listen: false).init(context);
  }

  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var homeController = Provider.of<HomeProviderController>(context);

    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.surface,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: GestureDetector(
          onTap: () => navigationService.push(AddressView.routeName),
        ),
        title: Text(
          homeController.getAddress,
          style: GoogleFonts.raleway(
            color: Constants.blackColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => navigationService.push(AddressView.routeName),
            icon: const Icon(
              Icons.circle,
              color: Constants.blackColor,
              size: 18,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                homeController.promotionalBanner.isNotEmpty
                    ? Container(
                        height: 120,
                        margin: const EdgeInsets.only(right: 10),
                        child: ListPromotionalBanner(
                          listBanners: homeController.promotionalBanner,
                        ),
                      )
                    : Container(),
                homeController.isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Constants.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : (homeController.services.isNotEmpty
                        ? ListServices(
                            listServices: homeController.services,
                          )
                        : Container()),
              ],
            ),
          ),
          homeController.services.isNotEmpty
              ? Container()
              : Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.warning_outlined,
                              size: 130,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Infelizmente não atendemos na sua região.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Constants.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          labelText: 'Alterar endereço',
                          width: Utils.mediaQuery(context, 1),
                          height: 40,
                          borderRadius: 15,
                          elevation: 3,
                          color: Constants.primaryContainer,
                          colorText: Constants.blackColor,
                          colorButton: Constants.primaryContainer,
                          onTap: () =>
                              navigationService.push(AddressView.routeName),
                        ),
                      ],
                    ),
                  ),
              ),
        ],
      ),
    );
  }
}
