import 'package:equatable/equatable.dart';
import 'package:event_app/model/event/event_details/classifications/classification_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification_obj.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassificationObj extends Equatable {
  @JsonKey(name: 'primary')
  final bool primary;

  @JsonKey(name: 'segment')
  final ClassificationDetails segment;

  @JsonKey(name: 'genre')
  final ClassificationDetails genre;

  @JsonKey(name: 'subGenre')
  final ClassificationDetails subGenre;

  ClassificationObj({
    required this.primary,
    required this.segment,
    required this.genre,
    required this.subGenre,
  });

  factory ClassificationObj.fromJson(Map<String, dynamic> json) => _$ClassificationObjFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationObjToJson(this);

  @override
  List<Object> get props => [
        primary,
        segment,
        genre,
        subGenre,
      ];
}
