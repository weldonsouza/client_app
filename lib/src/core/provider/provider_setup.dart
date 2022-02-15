import 'package:client_app/src/app/pages/address/address_viewModel.dart';
import 'package:client_app/src/app/pages/home/home_viewModel.dart';
import 'package:client_app/src/app/pages/login/login_viewModel.dart';
import 'package:client_app/src/app/pages/schedule_service/schedule_service_viewModel.dart';
import 'package:client_app/src/app/pages/service/service_viewModel.dart';
import 'package:client_app/src/data/datasources/address/address_remote.dart';
import 'package:client_app/src/data/datasources/service/service_remote.dart';
import 'package:client_app/src/data/datasources/user/user_remote.dart';
import 'package:client_app/src/data/repositories/address/address_repository.dart';
import 'package:client_app/src/data/repositories/service/service_repository.dart';
import 'package:client_app/src/data/repositories/user/user_repository.dart';
import 'package:client_app/src/domain/entities/address_entity.dart';
import 'package:client_app/src/domain/entities/service_entity.dart';
import 'package:client_app/src/domain/entities/user_entity.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/datasources/network/client_app_api_service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: ClientAppApiService.create(ClientAppClient().chopperClient)),

  ChangeNotifierProvider(create: (_) => AddressProviderController()),
  ChangeNotifierProvider(create: (_) => HomeProviderController()),
  ChangeNotifierProvider(create: (_) => ServiceProviderController()),
  ChangeNotifierProvider(create: (_) => ScheduleServiceProviderController()),
  ChangeNotifierProvider(create: (_) => LoginProviderController()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<AddressRepository, AddressEntity>(update: (_, addressRepository, __) => AddressEntity(addressRepository: addressRepository)),
  ProxyProvider<AddressRemote, AddressRepository>(update: (_, addressRemote, __) => AddressRepository(addressRemote: addressRemote)),
  ProxyProvider<ClientAppApiService, AddressRemote>(update: (_, ClientAppApiService, __) => AddressRemote(clientAppApiService: ClientAppApiService)),

  ProxyProvider<ServiceRepository, ServiceEntity>(update: (_, serviceRepository, __) => ServiceEntity(serviceRepository: serviceRepository)),
  ProxyProvider<ServiceRemote, ServiceRepository>(update: (_, serviceRemote, __) => ServiceRepository(serviceRemote: serviceRemote)),
  ProxyProvider<ClientAppApiService, ServiceRemote>(update: (_, ClientAppApiService, __) => ServiceRemote(clientAppApiService: ClientAppApiService)),

  ProxyProvider<UserRepository, UserEntity>(update: (_, userRepository, __) => UserEntity(userRepository: userRepository)),
  ProxyProvider<UserRemote, UserRepository>(update: (_, userRemote, __) => UserRepository(userRemote: userRemote)),
  ProxyProvider<ClientAppApiService, UserRemote>(update: (_, ClientAppApiService, __) => UserRemote(clientAppApiService: ClientAppApiService)),
];

List<SingleChildWidget> uiConsumableProviders = [];