import 'package:json_annotation/json_annotation.dart';

part 'graph_model.g.dart';

@JsonSerializable()
class GraphModel {
  @JsonKey(name: 'graph_base64_image')
  String graphBase64Image;

  GraphModel({required this.graphBase64Image});

  factory GraphModel.fromJson(Map<String, dynamic> json) {
    return _$GraphModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GraphModelToJson(this);
}
