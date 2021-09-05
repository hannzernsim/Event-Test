// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sales _$SalesFromJson(Map<String, dynamic> json) {
  return Sales(
    details: SalesDetails.fromJson(json['public'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SalesToJson(Sales instance) => <String, dynamic>{
      'public': instance.details.toJson(),
    };
