import 'package:json_annotation/json_annotation.dart';

part 'equation_model.g.dart';

@JsonSerializable()
class EquationModel {
  List<String> equation;

  EquationModel({required this.equation});

  factory EquationModel.fromJson(Map<String, dynamic> json) {
    return _$EquationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EquationModelToJson(this);
}
