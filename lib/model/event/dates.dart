import 'package:equatable/equatable.dart';
import 'package:event_app/model/event/date_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dates.g.dart';

@JsonSerializable(explicitToJson: true)
class Dates extends Equatable {
  @JsonKey(name: 'start')
  final DateInfo start;

  Dates({
    required this.start,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);

  @override
  List<Object> get props => [start];
}
