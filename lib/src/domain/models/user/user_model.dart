class UserModel {
  final String? gender;
  final String? socialGender;
  final String? name;
  final String? socialName;
  final String? phone;
  final String? address;
  final String? number;
  final String? cityId;
  final String? stateId;
  final String? districtId;
  final String? zipCode;
  final String? complement;

  UserModel({
    this.gender,
    this.socialGender,
    this.name,
    this.socialName,
    this.phone,
    this.address,
    this.number,
    this.cityId,
    this.stateId,
    this.districtId,
    this.zipCode,
    this.complement,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : gender = json['gender'] as String?,
        socialGender = json['socialGender'] as String?,
        name = json['name'] as String?,
        socialName = json['socialName'] as String?,
        phone = json['phone'] as String?,
        address = json['address'] as String?,
        number = json['number'] as String?,
        cityId = json['cityId'] as String?,
        stateId = json['stateId'] as String?,
        districtId = json['districtId'] as String?,
        zipCode = json['zipCode'] as String?,
        complement = json['complement'] as String?;

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'socialGender': socialGender,
        'name': name,
        'socialName': socialName,
        'phone': phone,
        'address': address,
        'number': number,
        'cityId': cityId,
        'stateId': stateId,
        'districtId': districtId,
        'zipCode': zipCode,
        'complement': complement
      };
}
