// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    name: json['name'] as String,
    images: (json['images'] as List<dynamic>)
        .map((e) => ImageData.fromJson(e as Map<String, dynamic>))
        .toList(),
    dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
    sales: Sales.fromJson(json['sales'] as Map<String, dynamic>),
    classifications: (json['classifications'] as List<dynamic>)
        .map((e) => ClassificationObj.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'dates': instance.dates.toJson(),
      'sales': instance.sales.toJson(),
      'classifications':
          instance.classifications.map((e) => e.toJson()).toList(),
    };
