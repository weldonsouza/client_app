import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? categoryId;
  final String? name;
  final String? description;
  final String? summary;
  final int? price;
  final List<String>? images;
  final int? duration;
  final bool? isActive;
  final int? order;
  final int? maximumDuration;
  final int? minimumDuration;
  final String? contraIndication;
  final String? howToPrepare;
  final List<dynamic>? invalidDates;
  final int? startingTime;
  final int? endingTime;
  final int? maximumDurationService;
  final int? minimumAppointmentHours;

  ServiceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categoryId,
    this.name,
    this.description,
    this.summary,
    this.price,
    this.images,
    this.duration,
    this.isActive,
    this.order,
    this.maximumDuration,
    this.minimumDuration,
    this.contraIndication,
    this.howToPrepare,
    this.invalidDates,
    this.startingTime,
    this.endingTime,
    this.maximumDurationService,
    this.minimumAppointmentHours,
  });

  ServiceModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        deletedAt = json['deletedAt'] as String?,
        categoryId = json['categoryId'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        summary = json['summary'] as String?,
        price = json['price'] as int?,
        images =
            (json['images'] as List?)?.map((dynamic e) => e as String).toList(),
        duration = json['duration'] as int?,
        isActive = json['isActive'] as bool?,
        order = json['order'] as int?,
        maximumDuration = json['maximumDuration'] as int?,
        minimumDuration = json['minimumDuration'] as int?,
        contraIndication = json['contraIndication'] as String?,
        howToPrepare = json['howToPrepare'] as String?,
        invalidDates =
            (json['invalidDates'] as List?)?.map((dynamic e) => e).toList(),
        startingTime = json['startingTime'] as int?,
        endingTime = json['endingTime'] as int?,
        maximumDurationService = json['maximumDurationService'] as int?,
        minimumAppointmentHours = json['minimumAppointmentHours'] as int?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'categoryId': categoryId,
        'name': name,
        'description': description,
        'summary': summary,
        'price': price,
        'images': images,
        'duration': duration,
        'isActive': isActive,
        'order': order,
        'maximumDuration': maximumDuration,
        'minimumDuration': minimumDuration,
        'contraIndication': contraIndication,
        'howToPrepare': howToPrepare,
        'invalidDates': invalidDates,
        'startingTime': startingTime,
        'endingTime': endingTime,
        'maximumDurationService': maximumDurationService,
        'minimumAppointmentHours': minimumAppointmentHours,
      };
}
