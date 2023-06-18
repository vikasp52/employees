part of 'add_edit_employee_dart_cubit.dart';

@freezed
abstract class AddEditEmployeeState with _$AddEditEmployeeState {
  const factory AddEditEmployeeState({
    required String name,
    required String role,
    required String startDate,
    String? endDate,
    required bool isSaving,
    required bool isSaved,
    required bool isNameValid,
    required bool isRoleValid,
    required bool isStartDateValid,
    String? errorMessage,
  }) = _AddEditEmployeeDartState;

  factory AddEditEmployeeState.initial() => const AddEditEmployeeState(
        name: '',
        role: '',
        startDate: '',
        isSaving: false,
        isSaved: false,
        isNameValid: false,
        isRoleValid: false,
        isStartDateValid: false,
      );
}
