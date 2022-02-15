import 'package:client_app/src/data/datasources/service/service_remote.dart';
import 'package:client_app/src/domain/models/service/service_result.dart';

class ServiceRepository {
  ServiceRemote serviceRemote;

  ServiceRepository({required this.serviceRemote});

  Future<ServiceResult?> findAllServices(String districtId) async {
    return await serviceRemote.findAllServices(districtId);
  }
}