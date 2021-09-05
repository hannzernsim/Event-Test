// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dates _$DatesFromJson(Map<String, dynamic> json) {
  return Dates(
    start: DateInfo.fromJson(json['start'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
      'start': instance.start.toJson(),
    };
