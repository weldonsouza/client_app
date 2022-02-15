import 'dart:async';

import 'package:flutter/material.dart';
import 'package:client_app/src/app/pages/address/address_viewModel.dart';
import 'package:client_app/src/app/pages/login/login_viewModel.dart';
import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/domain/models/service/items_model.dart';
import 'package:provider/provider.dart';

class HomeProviderController with ChangeNotifier {
  final _serviceEntity = setupLocator.serviceLocatorServiceEntity;
  var addressController;
  var loginController;

  String address = '';

  List<Items> services = <Items>[];
  List<dynamic> promotionalBanner = <dynamic>[];

  bool isLoading = false;

  bool get getIsLoading => isLoading;
  String get getAddress => address;

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setPromotionalBanner(List<dynamic> value) {
    promotionalBanner = value;
    notifyListeners();
  }

  setServices(List<Items> value) {
    services.clear();
    services = value;
    notifyListeners();
  }

  setAddress(String value) {
    address = value;
    notifyListeners();
  }

  void init(context) async {
    loginController = Provider.of<LoginProviderController>(context, listen: false);
    addressController = Provider.of<AddressProviderController>(context, listen: false);
    services.clear();

    if (loginController.previousPage == 'singup') {
      setAddress(loginController.number.isNotEmpty
          ? '${loginController.street}, ${addressController.number}'
          : '${loginController.street}');
      findAllServices(districtId: loginController.addressModelResult.districtId);
    } else if (loginController.previousPage == 'address') {
      setAddress(addressController.number.isNotEmpty
          ? '${addressController.street}, ${addressController.number}'
          : '${addressController.street}');
      findAllServices(districtId: addressController.addressModelResult.districtId);
    } else if(loginController.mapAddress['districtId'].isNotEmpty) {
      setAddress(loginController.mapAddress['number'].toString().isNotEmpty
          ? '${loginController.mapAddress['address']}, ${loginController.mapAddress['number']}'
          : '${loginController.mapAddress['address']}');
      findAllServices(districtId: loginController.mapAddress['districtId']);
    }
  }

  void dispose() {
    services.clear();
  }

  Future<String> findAllServices({required String districtId}) async {
    setIsLoading(true);

    var response = await _serviceEntity.executeFindAllServices(districtId);
    if (response != null && response.isNotEmpty) setServices(response);
    // TODO - falta validar como será retornado o formato dos banner promocionais
    //if (response != null && response.isNotEmpty) setPromotionalBanner(response.imagens);

    setIsLoading(false);
    return "success";
  }
}