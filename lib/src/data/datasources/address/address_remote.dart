import 'package:client_app/src/data/datasources/network/client_app_api_service.dart';
import 'package:client_app/src/domain/models/address/address_result.dart';

class AddressRemote {
  final ClientAppApiService clientAppApiService;

  AddressRemote({required this.clientAppApiService});

  Future<AddressResult?> findAddressByZipcode(String zipCode) async {
    try {
      final response = await clientAppApiService.findAddressByZipcode(zipCode);

      return response.body;
    } catch (e) {
      return null;
    }
  }
}
