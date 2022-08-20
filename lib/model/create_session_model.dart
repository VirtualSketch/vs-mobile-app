import 'package:json_annotation/json_annotation.dart';

part 'create_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateSessionModel {
  @JsonKey(name: 'session_id') final String? sessionId;

  CreateSessionModel({this.sessionId});

  factory CreateSessionModel.fromJson(Map<String, dynamic> json) {
    return _$CreateSessionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateSessionModelToJson(this);
}
