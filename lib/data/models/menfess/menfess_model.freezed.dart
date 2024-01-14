// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menfess_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MenfessModel _$MenfessModelFromJson(Map<String, dynamic> json) {
  return _MenfessModel.fromJson(json);
}

/// @nodoc
mixin _$MenfessModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  int get reactions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenfessModelCopyWith<MenfessModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenfessModelCopyWith<$Res> {
  factory $MenfessModelCopyWith(
          MenfessModel value, $Res Function(MenfessModel) then) =
      _$MenfessModelCopyWithImpl<$Res, MenfessModel>;
  @useResult
  $Res call({int id, int userId, String? body, int reactions});
}

/// @nodoc
class _$MenfessModelCopyWithImpl<$Res, $Val extends MenfessModel>
    implements $MenfessModelCopyWith<$Res> {
  _$MenfessModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? body = freezed,
    Object? reactions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenfessModelImplCopyWith<$Res>
    implements $MenfessModelCopyWith<$Res> {
  factory _$$MenfessModelImplCopyWith(
          _$MenfessModelImpl value, $Res Function(_$MenfessModelImpl) then) =
      __$$MenfessModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int userId, String? body, int reactions});
}

/// @nodoc
class __$$MenfessModelImplCopyWithImpl<$Res>
    extends _$MenfessModelCopyWithImpl<$Res, _$MenfessModelImpl>
    implements _$$MenfessModelImplCopyWith<$Res> {
  __$$MenfessModelImplCopyWithImpl(
      _$MenfessModelImpl _value, $Res Function(_$MenfessModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? body = freezed,
    Object? reactions = null,
  }) {
    return _then(_$MenfessModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenfessModelImpl implements _MenfessModel {
  const _$MenfessModelImpl(
      {required this.id,
      required this.userId,
      required this.body,
      this.reactions = 0});

  factory _$MenfessModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenfessModelImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String? body;
  @override
  @JsonKey()
  final int reactions;

  @override
  String toString() {
    return 'MenfessModel(id: $id, userId: $userId, body: $body, reactions: $reactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenfessModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.reactions, reactions) ||
                other.reactions == reactions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, body, reactions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenfessModelImplCopyWith<_$MenfessModelImpl> get copyWith =>
      __$$MenfessModelImplCopyWithImpl<_$MenfessModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenfessModelImplToJson(
      this,
    );
  }
}

abstract class _MenfessModel implements MenfessModel {
  const factory _MenfessModel(
      {required final int id,
      required final int userId,
      required final String? body,
      final int reactions}) = _$MenfessModelImpl;

  factory _MenfessModel.fromJson(Map<String, dynamic> json) =
      _$MenfessModelImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String? get body;
  @override
  int get reactions;
  @override
  @JsonKey(ignore: true)
  _$$MenfessModelImplCopyWith<_$MenfessModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
