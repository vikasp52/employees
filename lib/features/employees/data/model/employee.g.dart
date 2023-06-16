// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Employee _$$_EmployeeFromJson(Map<String, dynamic> json) => _$_Employee(
      id: json['id'] as int?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$$_EmployeeToJson(_$_Employee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
