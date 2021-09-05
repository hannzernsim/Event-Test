import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:event_app/model/event/event_list.dart';

part 'event_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class EventListResponse extends Equatable {
  @JsonKey(name: '_embedded')
  final EventList embedded;

  EventListResponse({
    required this.embedded,
  });

  factory EventListResponse.fromJson(Map<String, dynamic> json) =>
      _$EventListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventListResponseToJson(this);

  @override
  List<Object> get props => [embedded];
}
