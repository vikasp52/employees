part of 'employees_cubit.dart';

@freezed
abstract class EmployeesState with _$EmployeesState {
  //Getting employee data
  const factory EmployeesState.loading() = _Loading;
  const factory EmployeesState.loaded(List<Employee> employees) = _Loaded;
  const factory EmployeesState.error(String message) = _Error;

  //Detele employee state
  const factory EmployeesState.deleteInProgress() = _DeleteInProgress;
  const factory EmployeesState.deletedSuccessfully() = _DeletedSuccessfully;
  const factory EmployeesState.errorInDeleting(String message) =
      _ErrorInDeleting;
}
