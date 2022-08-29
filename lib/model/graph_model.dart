import 'package:json_annotation/json_annotation.dart';

part 'graph_model.g.dart';

@JsonSerializable()
class GraphModel {
  @JsonKey(name: 'graph_image_url')
  String graphImageUrl;

  GraphModel({required this.graphImageUrl});

  factory GraphModel.fromJson(Map<String, dynamic> json) {
    return _$GraphModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GraphModelToJson(this);
}
