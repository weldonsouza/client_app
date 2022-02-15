import 'service_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Items {
  @JsonKey(name: '_id')
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? name;
  final bool? isActive;
  final List<String>? images;
  final int? order;
  final List<ServiceModel>? services;

  Items({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.isActive,
    this.images,
    this.order,
    this.services,
  });

  Items.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        deletedAt = json['deletedAt'] as String?,
        name = json['name'] as String?,
        isActive = json['isActive'] as bool?,
        images =
            (json['images'] as List?)?.map((dynamic e) => e as String).toList(),
        order = json['order'] as int?,
        services = (json['services'] as List?)
            ?.map(
                (dynamic e) => ServiceModel.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        '_id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'name': name,
        'isActive': isActive,
        'images': images,
        'order': order,
        'services': services?.map((e) => e.toJson()).toList()
      };
}
