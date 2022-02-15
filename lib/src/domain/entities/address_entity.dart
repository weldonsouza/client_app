import 'package:client_app/src/data/repositories/address/address_repository.dart';
import 'package:client_app/src/domain/models/address/address_model.dart';
import 'package:client_app/src/domain/models/address/address_result.dart';

class AddressEntity {
  final AddressRepository addressRepository;

  AddressEntity({required this.addressRepository});

  Future<AddressModel?> executeFindAddressByZipcode(zipCode) async {
    AddressResult? addressResult = await addressRepository.findAddressByZipcode(zipCode);

    if (addressResult != null) {
      return addressResult.data;
    }
    return null;
  }
}
