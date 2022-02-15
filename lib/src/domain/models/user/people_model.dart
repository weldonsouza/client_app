import 'user_model.dart';

class PeopleModel {
  final UserModel? people;

  PeopleModel({
    this.people,
  });

  PeopleModel.fromJson(Map<String, dynamic> json)
      : people = (json['people'] as Map<String, dynamic>?) != null
            ? UserModel.fromJson(json['people'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'people': people?.toJson()};
}
