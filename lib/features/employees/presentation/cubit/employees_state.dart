part of 'employees_cubit.dart';

@freezed
abstract class EmployeesState with _$EmployeesState {
  const factory EmployeesState.loading() = _Loading;
  const factory EmployeesState.loaded(List<Employee> employees) = _Loaded;
  const factory EmployeesState.error(String message) = _Error;
}
