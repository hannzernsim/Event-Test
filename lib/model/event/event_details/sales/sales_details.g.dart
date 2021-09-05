// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesDetails _$SalesDetailsFromJson(Map<String, dynamic> json) {
  return SalesDetails(
    startDateTime: DateTime.parse(json['startDateTime'] as String),
    endDateTime: DateTime.parse(json['endDateTime'] as String),
  );
}

Map<String, dynamic> _$SalesDetailsToJson(SalesDetails instance) =>
    <String, dynamic>{
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
    };
