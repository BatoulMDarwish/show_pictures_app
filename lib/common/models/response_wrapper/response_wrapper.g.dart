// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseWrapper<T> _$$_ResponseWrapperFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_ResponseWrapper<T>(
      status: json['status'] as String?,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$$_ResponseWrapperToJson<T>(
  _$_ResponseWrapper<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'data': toJsonT(instance.data),
    };
