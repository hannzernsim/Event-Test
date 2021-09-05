// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationObj _$ClassificationObjFromJson(Map<String, dynamic> json) {
  return ClassificationObj(
    primary: json['primary'] as bool,
    segment:
        ClassificationDetails.fromJson(json['segment'] as Map<String, dynamic>),
    genre:
        ClassificationDetails.fromJson(json['genre'] as Map<String, dynamic>),
    subGenre: ClassificationDetails.fromJson(
        json['subGenre'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ClassificationObjToJson(ClassificationObj instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'segment': instance.segment.toJson(),
      'genre': instance.genre.toJson(),
      'subGenre': instance.subGenre.toJson(),
    };
