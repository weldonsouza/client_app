import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/src/app/widgets/custom_alert_service.dart';
import 'package:client_app/src/app/widgets/custom_button.dart';
import 'package:client_app/src/app/widgets/custom_card_service.dart';
import 'package:client_app/src/core/route/navigation_service.dart';
import 'package:client_app/src/core/utils/constants.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:provider/provider.dart';

import '../address/address_list_view.dart';
import 'schedule_service_viewModel.dart';

class ScheduleServiceView extends StatefulWidget {
  const ScheduleServiceView({Key? key}) : super(key: key);

  static String get routeName => '/scheduleservice';

  @override
  _ScheduleServiceViewState createState() => _ScheduleServiceViewState();
}

class _ScheduleServiceViewState extends State<ScheduleServiceView> {
  @override
  void initState() {
    super.initState();

    Provider.of<ScheduleServiceProviderController>(context, listen: false).init(context);
  }

  @override
  Widget build(BuildContext context) {
    //Controller do provider
    var scheduleServiceController = Provider.of<ScheduleServiceProviderController>(context);

    return Scaffold(
      backgroundColor: Constants.whiteColor,
      appBar: AppBar(
        backgroundColor: Constants.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Constants.blackColor),
        title: Text(
          '${scheduleServiceController.serviceController.service.name}',
          style: GoogleFonts.raleway(
            color: Constants.blackColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CustomCardService(
                  title: scheduleServiceController.getDate,
                  subTitle: scheduleServiceController.getTimeAndHours,
                  titleButton: 'Mudar',
                  iconData: Icons.today,
                  iconDataButton: Icons.edit_outlined,
                  visible: false,
                ),
                CustomCardService(
                  title: scheduleServiceController.getAddress,
                  subTitle: scheduleServiceController.getComplementCityState,
                  titleButton: 'Mudar',
                  iconData: Icons.location_on,
                  iconDataButton: Icons.edit_outlined,
                  visible: false,
                  onTap: () async {
                    await navigationService.push(AddressListView.routeName);
                  },
                ),
                CustomCardService(
                  title: 'Observações',
                  subTitle: scheduleServiceController.getObservation.isNotEmpty ? scheduleServiceController.getObservation : '',
                  titleButton: scheduleServiceController.getObservation.isNotEmpty ? 'Trocar' : 'Adicionar',
                  iconData: Icons.assignment,
                  iconDataButton: Icons.add,
                  widthButton: scheduleServiceController.getObservation.isNotEmpty ? 85 : 100,
                  onTap: () {
                    CustomAlertService.showAlert(
                      context: context,
                      title: 'Alguma observação?',
                      warning: 'Tem alguma alergia? Quer avisar algo?',
                      labelText: 'Eu tenho a pele muito oleosa.',
                      textController: scheduleServiceController.textObservationController,
                      textValue: scheduleServiceController.getObservation,
                      textOnChange: (value) => scheduleServiceController.setObservation(value),
                      iconData: Icons.assignment,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                CustomCardService(
                  title: 'Cupom de Desconto',
                  subTitle: scheduleServiceController.getCoupon.isNotEmpty ? scheduleServiceController.getCoupon : '',
                  titleButton: scheduleServiceController.getCoupon.isNotEmpty ? 'Trocar' : 'Adicionar',
                  iconData: Icons.turned_in_outlined,
                  iconDataButton: Icons.add,
                  widthButton: scheduleServiceController.getCoupon.isNotEmpty ? 85 : 100,
                  onTap: () {
                    CustomAlertService.showAlert(
                      context: context,
                      title: 'Adicione cupom de desconto',
                      warning: 'Cupom válido',
                      labelText: 'AMO2022',
                      textController: scheduleServiceController.textCouponController,
                      textValue: scheduleServiceController.getCoupon,
                      textOnChange: (value) => scheduleServiceController.setCoupon(value),
                      iconData: Icons.turned_in_outlined,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                Container(
                  width: Utils.mediaQuery(context, 1),
                  height: Utils.mediaQuery(context, 0.7),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                    color: Constants.surface2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
                        child: Text(
                          'Resumo de valores',
                          style: GoogleFonts.raleway(
                            color: Constants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: Utils.mediaQuery(context, 1),
                        height: 0.7,
                        color: Constants.blackColor.withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Serviços',
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              scheduleServiceController.getPriceService,
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cupom de Desconto',
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              scheduleServiceController.getPriceCoupon,
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total a pagar',
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              scheduleServiceController.getPriceService,
                              style: GoogleFonts.raleway(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomButton(
                      labelText: 'Finalizar pedido',
                      width: 130,
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
                        await scheduleServiceController.createServiceSchedule();
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
