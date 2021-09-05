import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageData extends Equatable {
  @JsonKey(name: 'url')
  final String url;

  ImageData({
    required this.url,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDataToJson(this);

  @override
  List<Object> get props => [];
}
