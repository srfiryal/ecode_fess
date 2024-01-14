import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int total,
    required int skip,
    required int limit,
    required dynamic posts,
    required dynamic comments,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, Object?> json)
  => _$PaginationModelFromJson(json);
}