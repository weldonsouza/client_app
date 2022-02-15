import '../address/address_model.dart';

class ScheduleServiceModel {
  final String? dateTime;
  final AddressModel? address;
  final String? observations;
  final String? couponId;
  final String? paymentMethod;
  final String? paymentMethodId;
  final String? serviceId;

  ScheduleServiceModel({
    this.dateTime,
    this.address,
    this.observations,
    this.couponId,
    this.paymentMethod,
    this.paymentMethodId,
    this.serviceId,
  });

  ScheduleServiceModel.fromJson(Map<String, dynamic> json)
      : dateTime = json['dateTime'] as String?,
        address = (json['address'] as Map<String, dynamic>?) != null
            ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
        observations = json['observations'] as String?,
        couponId = json['couponId'] as String?,
        paymentMethod = json['paymentMethod'] as String?,
        paymentMethodId = json['paymentMethodId'] as String?,
        serviceId = json['serviceId'] as String?;

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'address': address?.toJson(),
        'observations': observations,
        'couponId': couponId,
        'paymentMethod': paymentMethod,
        'paymentMethodId': paymentMethodId,
        'serviceId': serviceId
      };
}
