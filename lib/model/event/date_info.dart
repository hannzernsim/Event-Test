import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_info.g.dart';

@JsonSerializable(explicitToJson: true)
class DateInfo extends Equatable {
  @JsonKey(name: 'dateTime')
  final DateTime dateTime;

  DateInfo({
    required this.dateTime,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) =>
      _$DateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DateInfoToJson(this);

  @override
  List<Object> get props => [dateTime];
}
