import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales_details.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesDetails extends Equatable {
  @JsonKey(name: 'startDateTime')
  final DateTime startDateTime;

  @JsonKey(name: 'endDateTime')
  final DateTime endDateTime;

  SalesDetails({
    required this.startDateTime,
    required this.endDateTime,
  });

  factory SalesDetails.fromJson(Map<String, dynamic> json) => _$SalesDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDetailsToJson(this);

  @override
  List<Object> get props => [
        startDateTime,
        endDateTime,
      ];
}
