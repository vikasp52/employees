part of 'add_edit_employee_dart_cubit.dart';

@freezed
abstract class AddEditEmployeeDartState with _$AddEditEmployeeDartState {
  const factory AddEditEmployeeDartState.innitial() = _initial;
  const factory AddEditEmployeeDartState.savingDetailsInProgress() =
      _SavingDetailsInProgress;
  const factory AddEditEmployeeDartState.saved() = _Saved;
  const factory AddEditEmployeeDartState.error(String message) = _Error;
}
