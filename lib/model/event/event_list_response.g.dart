// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListResponse _$EventListResponseFromJson(Map<String, dynamic> json) {
  return EventListResponse(
    embedded: EventList.fromJson(json['_embedded'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventListResponseToJson(EventListResponse instance) =>
    <String, dynamic>{
      '_embedded': instance.embedded.toJson(),
    };
