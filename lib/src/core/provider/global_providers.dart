import 'package:client_app/src/data/datasources/address/address_remote.dart';
import 'package:client_app/src/data/datasources/service/service_remote.dart';
import 'package:client_app/src/data/datasources/user/user_remote.dart';
import 'package:client_app/src/data/repositories/address/address_repository.dart';
import 'package:client_app/src/data/repositories/service/service_repository.dart';
import 'package:client_app/src/data/repositories/user/user_repository.dart';
import 'package:client_app/src/domain/entities/address_entity.dart';
import 'package:client_app/src/domain/entities/service_entity.dart';
import 'package:client_app/src/domain/entities/user_entity.dart';

import '../../data/datasources/local/user_local.dart';
import '../../data/datasources/network/client_app_api_service.dart';

mixin setupLocator {
  // Api Service
  static ClientAppApiService serviceLocatorClientAppApiService = ClientAppApiService.create(ClientAppClient().chopperClient);

  // Address
  static AddressEntity serviceLocatorAddressEntity = AddressEntity(addressRepository: serviceLocatorAddressRepository);
  static AddressRepository serviceLocatorAddressRepository = AddressRepository(addressRemote: serviceLocatorAddressRemote);
  static AddressRemote serviceLocatorAddressRemote = AddressRemote(clientAppApiService: serviceLocatorClientAppApiService);

  // Service
  static ServiceEntity serviceLocatorServiceEntity = ServiceEntity(serviceRepository: serviceLocatorServiceRepository);
  static ServiceRepository serviceLocatorServiceRepository = ServiceRepository(serviceRemote: serviceLocatorServiceRemote);
  static ServiceRemote serviceLocatorServiceRemote = ServiceRemote(clientAppApiService: serviceLocatorClientAppApiService);

  // User
  static UserEntity serviceLocatorUserEntity = UserEntity(userRepository: serviceLocatorUserRepository);
  static UserRepository serviceLocatorUserRepository = UserRepository(userRemote: serviceLocatorUserRemote);
  static UserRemote serviceLocatorUserRemote = UserRemote(clientAppApiService: serviceLocatorClientAppApiService);

  static UserLocal serviceLocatorUserLocal = UserLocal();
}
