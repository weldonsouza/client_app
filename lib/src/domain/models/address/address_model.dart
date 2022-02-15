class AddressModel {
  String? zipCode;
  String? state;
  String? city;
  String? district;
  String? address;
  String? country;
  String? cityId;
  String? stateId;
  String? districtId;
  String? countryId;

  AddressModel({
    this.zipCode,
    this.state,
    this.city,
    this.district,
    this.address,
    this.country,
    this.cityId,
    this.stateId,
    this.districtId,
    this.countryId,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : zipCode = json['zipCode'] as String?,
        state = json['state'] as String?,
        city = json['city'] as String?,
        district = json['district'] as String?,
        address = json['address'] as String?,
        country = json['country'] as String?,
        cityId = json['cityId'] as String?,
        stateId = json['stateId'] as String?,
        districtId = json['districtId'] as String?,
        countryId = json['countryId'] as String?;

  Map<String, dynamic> toJson() => {
        'zipCode': zipCode,
        'state': state,
        'city': city,
        'district': district,
        'address': address,
        'country': country,
        'cityId': cityId,
        'stateId': stateId,
        'districtId': districtId,
        'countryId': countryId
      };
}
