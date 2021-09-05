import 'package:equatable/equatable.dart';
import 'package:event_app/model/event/event_details/sales/sales_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales.g.dart';

@JsonSerializable(explicitToJson: true)
class Sales extends Equatable {
  @JsonKey(name: 'public')
  final SalesDetails details;

  Sales({
    required this.details,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  Map<String, dynamic> toJson() => _$SalesToJson(this);

  @override
  List<Object> get props => [
        details,
      ];
}
