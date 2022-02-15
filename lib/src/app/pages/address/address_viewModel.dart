import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:client_app/src/core/provider/global_providers.dart';
import 'package:client_app/src/domain/models/address/address_model.dart';

class AddressProviderController with ChangeNotifier {
  final _addressEntity = setupLocator.serviceLocatorAddressEntity;

  var zipCodeFormatter = MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController complementController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  bool isLoading = false;
  String zipCode = '';
  String street = '';
  String number = '';
  String complement = '';
  String district = '';
  String city = '';
  String state = '';
  late AddressModel addressModelResult;

  bool get getIsLoading => isLoading;
  String get getZipCode => zipCode;
  String get getStreet => street;
  String get getNumber => number;
  String get getComplement => complement;
  String get getDistrict => district;
  String get getCity => city;
  String get getState => state;
  AddressModel get getAddressModelResult => addressModelResult;

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setZipCode(String value) {
    zipCode = value;
    if (zipCode.length > 8) {
      findAddressByZipCode();
    }
    notifyListeners();
  }

  setStreet(String value) {
    street = value;
    notifyListeners();
  }

  setNumber(String value) {
    number = value;
    notifyListeners();
  }

  setComplement(String value) {
    complement = value;
    notifyListeners();
  }

  setDistrict(String value) {
    district = value;
    notifyListeners();
  }

  setCity(String value) {
    city = value;
    notifyListeners();
  }

  setState(String value) {
    state = value;
    notifyListeners();
  }

  setAddressModelResult(AddressModel value) {
    addressModelResult = value;
    notifyListeners();
  }

  bool get isValidButtonNext {
    return zipCode.isNotEmpty &&
        zipCode.length == 9 &&
        street.isNotEmpty &&
        street.length >= 3 &&
        district.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty;
  }

  Future findAddressByZipCode() async {
    setIsLoading(true);

    AddressModel? addressResult = await _addressEntity.executeFindAddressByZipcode(zipCode);

    if(addressResult != null) {
      streetController.text = addressResult.address!;
      districtController.text = addressResult.district!;
      cityController.text = addressResult.city!;
      stateController.text = addressResult.state!;

      setStreet(addressResult.address!);
      setDistrict(addressResult.district!);
      setCity(addressResult.city!);
      setState(addressResult.state!);
      setAddressModelResult(addressResult);

      isValidButtonNext;
    }

    setIsLoading(false);
  }

  void clearFields() {
    setZipCode('');
    setStreet('');
    setNumber('');
    setComplement('');
    setDistrict('');
    setCity('');
    setState('');
  }
}
