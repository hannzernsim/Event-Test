import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassificationDetails extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  ClassificationDetails({
    required this.id,
    required this.name,
  });

  factory ClassificationDetails.fromJson(Map<String, dynamic> json) => _$ClassificationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationDetailsToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
