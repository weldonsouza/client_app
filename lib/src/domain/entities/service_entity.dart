import 'package:client_app/src/data/repositories/service/service_repository.dart';
import 'package:client_app/src/domain/models/service/items_model.dart';
import 'package:client_app/src/domain/models/service/service_result.dart';

class ServiceEntity {
  ServiceRepository serviceRepository;

  ServiceEntity({required this.serviceRepository});

  Future<List<Items>?> executeFindAllServices(String districtId) async {
    ServiceResult? serviceResult = await serviceRepository.findAllServices(districtId);

    if (serviceResult != null) {
      return serviceResult.data!.items;
    }
    return null;
  }
}
