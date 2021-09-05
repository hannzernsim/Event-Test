import 'package:equatable/equatable.dart';
import 'package:event_app/model/event/dates.dart';
import 'package:event_app/model/event/event_details/classifications/classification_obj.dart';
import 'package:event_app/model/event/event_details/sales/sales.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:event_app/model/event/image_data.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'images')
  final List<ImageData> images;

  @JsonKey(name: 'dates')
  final Dates dates;

  @JsonKey(name: 'sales')
  final Sales sales;

  @JsonKey(name: 'classifications')
  final List<ClassificationObj> classifications;

  Event({
    required this.id,
    required this.name,
    required this.images,
    required this.dates,
    required this.sales,
    required this.classifications,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        images,
        dates,
        sales,
        classifications,
      ];
}
