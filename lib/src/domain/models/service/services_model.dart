import 'items_model.dart';

class ServicesModel {
  final List<Items>? items;

  ServicesModel({
    this.items,
  });

  ServicesModel.fromJson(Map<String, dynamic> json)
      : items = (json['servicesGroupedByCategories'] as List?)
            ?.map((dynamic e) => Items.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'servicesGroupedByCategories': items?.map((e) => e.toJson()).toList()};
}
