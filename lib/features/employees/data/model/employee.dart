// ignore_for_file: invalid_annotation_target

// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    required String? name,
    required String? role,
    required String? startDate,
    String? endDate,
  }) = _Employee;

  factory Employee.fromJson(Map<String, Object?> json) =>
      _$EmployeeFromJson(json);
}
