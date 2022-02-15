import '../../../domain/models/service/service_result.dart';
import '../network/client_app_api_service.dart';

class ServiceRemote {
  ClientAppApiService clientAppApiService;

  ServiceRemote({required this.clientAppApiService});

  Future<ServiceResult?> findAllServices(String districtId) async {
    try {
      final response;

      return null;
    } catch (e) {
      return null;
    }
  }
}