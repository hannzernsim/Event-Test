// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateInfo _$DateInfoFromJson(Map<String, dynamic> json) {
  return DateInfo(
    dateTime: DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$DateInfoToJson(DateInfo instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
    };
