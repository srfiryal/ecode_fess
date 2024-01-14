import 'package:freezed_annotation/freezed_annotation.dart';

part 'menfess_model.freezed.dart';
part 'menfess_model.g.dart';

@freezed
class MenfessModel with _$MenfessModel {
  const factory MenfessModel({
    required int id,
    required int userId,
    required String? body,
    required int? reactions,
  }) = _MenfessModel;

  factory MenfessModel.fromJson(Map<String, Object?> json)
  => _$MenfessModelFromJson(json);
}