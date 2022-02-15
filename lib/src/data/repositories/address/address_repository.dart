import 'package:client_app/src/data/datasources/address/address_remote.dart';
import 'package:client_app/src/domain/models/address/address_result.dart';

class AddressRepository {
  final AddressRemote addressRemote;

  AddressRepository({required this.addressRemote});

  Future<AddressResult?> findAddressByZipcode(String zipCode) async {
    return await addressRemote.findAddressByZipcode(zipCode);
  }
}
