import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:client_app/src/app/pages/address/address_viewModel.dart';
import 'package:client_app/src/app/pages/service/service_viewModel.dart';
import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/core/utils/utils.dart';
import 'package:client_app/src/domain/models/address/address_model.dart';
import 'package:client_app/src/domain/models/service/schedule_service_model.dart';
import 'package:provider/provider.dart';

class ScheduleServiceProviderController with ChangeNotifier {
  final _scheduleServiceEntity = setupLocator.serviceLocatorServiceEntity;

  var addressController;
  var serviceController;

  String observation = '';
  String coupon = '';
  bool isLoading = false;

  TextEditingController textObservationController = TextEditingController();
  TextEditingController textCouponController = TextEditingController();

  bool get getIsLoading => isLoading;
  String get getObservation => observation;
  String get getCoupon => coupon;

  String get getDate => DateFormat("d 'de' MMMM").format(serviceController.selectedDate!);
  String get getTimeAndHours => '${serviceController.selectedTime!.hour}:${serviceController.selectedTime!.minute == 0
      ? '00'
      : serviceController.selectedTime!.minute}h';

  String get getAddress => addressController.number.isNotEmpty
      ? '${addressController.street}, ${addressController.number}'
      : '${addressController.street}, s/n';

  String get getComplementCityState => addressController.complement.isNotEmpty
      ? '${addressController.complement}\n${addressController.city} - ${addressController.state}'
      : '${addressController.city} - ${addressController.state}';

  String get getPriceService => 'R\$${formatFraction.format(serviceController.service.price)}';
  String get getPriceCoupon => '-R\$0,00';
  String get getTotalPaymentService => 'R\$${formatFraction.format(serviceController.service.price)}';

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setObservation(String value) {
    observation = value;
    notifyListeners();
  }

  setCoupon(String value) {
    coupon = value;
    notifyListeners();
  }

  void init(context) async {
    addressController = Provider.of<AddressProviderController>(context, listen: false);
    serviceController = Provider.of<ServiceProviderController>(context, listen: false);
  }

  Future<String> createServiceSchedule() async {
    setIsLoading(true);
    ScheduleServiceModel scheduleServiceModel = ScheduleServiceModel(
      dateTime: DateFormat('yyyy-MM-dd hh:mm').format(serviceController.joinDateTime),
      address: AddressModel(
        address: addressController.street,
        zipCode: addressController.zipCode,
        city: addressController.city,
        state: addressController.state,
        district: addressController.district,
        country: addressController.getAddressModelResult.country,
      ),
      observations: getObservation,
      couponId: null,
      serviceId: serviceController.getServiceId,
    );

    //var response = await _scheduleServiceEntity.executeCreateServiceSchedule(scheduleServiceModel);
    //if (response != null) NavigationService.showSnackbarMessage(response.message!, true);

    setIsLoading(false);
    return "success";
  }
}