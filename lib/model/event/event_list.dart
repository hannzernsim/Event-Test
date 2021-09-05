import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:event_app/model/event/event.dart';

part 'event_list.g.dart';

@JsonSerializable(explicitToJson: true)
class EventList extends Equatable {
  @JsonKey(name: 'events')
  final List<Event> events;

  EventList({
    required this.events,
  });

  factory EventList.fromJson(Map<String, dynamic> json) =>
      _$EventListFromJson(json);

  Map<String, dynamic> toJson() => _$EventListToJson(this);

  @override
  List<Object> get props => [events];
}
