// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/data/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_employee_dart_state.dart';
part 'add_edit_employee_dart_cubit.freezed.dart';

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  AddEditEmployeeCubit({
    this.employee,
    required this.employeeRepository,
  }) : super(AddEditEmployeeState.initial()) {
    if (employee != null) {
      emit(
        state.copyWith(
          name: employee!.name!,
          role: employee!.role!,
          startDate: employee!.startDate!,
          endDate: employee!.endDate == null ? null : employee!.endDate!,
        ),
      );
    }
  }

  final EmployeeRepository employeeRepository;
  final Employee? employee;

  void updateName(String name) {
    emit(
      state.copyWith(
        name: name,
        errorMessage: null,
      ),
    );
  }

  void updateRole(String role) {
    emit(
      state.copyWith(
        role: role,
        errorMessage: null,
      ),
    );
  }

  void updateStartDate(String date) {
    emit(
      state.copyWith(
        startDate: date,
        errorMessage: null,
      ),
    );
  }

  void updateEndDate(String date) {
    emit(
      state.copyWith(
        endDate: date,
        errorMessage: null,
      ),
    );
  }

  void selectDate({
    required DateTime? selectedDay,
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(startDate: selectedDay?.toIso8601String() ?? ''),
      );
    } else {
      emit(
        state.copyWith(endDate: selectedDay?.toIso8601String() ?? ''),
      );
    }
  }

//This method is called when save button is pressed and user won't change the
//date
  void selectDatePress({
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(
          startDate: DateTime.now().toIso8601String(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          endDate: DateTime.now().toIso8601String(),
        ),
      );
    }
  }

  void selectToday({
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(startDate: DateTime.now().toIso8601String()),
      );
    } else {
      emit(
        state.copyWith(endDate: DateTime.now().toIso8601String()),
      );
    }
  }

  void selectNextMonday({
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(
          startDate: _getNextWeekday(DateTime.now(), DateTime.monday)
              .toIso8601String(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          endDate: _getNextWeekday(DateTime.now(), DateTime.monday)
              .toIso8601String(),
        ),
      );
    }
  }

  void selectNextTuesday({
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(
          startDate: _getNextWeekday(DateTime.now(), DateTime.tuesday)
              .toIso8601String(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          endDate: _getNextWeekday(DateTime.now(), DateTime.tuesday)
              .toIso8601String(),
        ),
      );
    }
  }

  void selectAfterOneWeek({
    required bool isStartDate,
  }) {
    if (isStartDate) {
      emit(
        state.copyWith(
          startDate: DateTime.parse(state.startDate)
              .add(
                const Duration(
                  days: 7,
                ),
              )
              .toIso8601String(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          endDate: state.endDate == null
              ? DateTime.now().toIso8601String()
              : DateTime.parse(state.endDate!)
                  .add(
                    const Duration(
                      days: 7,
                    ),
                  )
                  .toIso8601String(),
        ),
      );
    }
  }

  DateTime _getNextWeekday(DateTime date, int weekday) {
    final daysUntilNextWeekday = (weekday - date.weekday + 7) % 7;
    return date.add(Duration(days: daysUntilNextWeekday));
  }

  Future<void> addEmployee() async {
    final isNameValid = state.name.isNotEmpty;
    final isRoleValid = state.role.isNotEmpty;
    final isStartDateValid = state.startDate.isNotEmpty;

    emit(state.copyWith(isSaving: true));

    if (isNameValid && isRoleValid && isStartDateValid) {
      emit(state.copyWith(isSaving: true));

      final Either<String, int> employeeResponse;

      final employeeData = Employee(
        name: state.name,
        role: state.role,
        startDate: state.startDate,
        endDate: state.endDate,
      );

      if (employee == null) {
        employeeResponse = await employeeRepository.saveEmployeeDetails(
          employeeData,
        );
      } else {
        final employeeData = Employee(
          id: employee!.id,
          name: state.name,
          role: state.role,
          startDate: state.startDate,
          endDate: state.endDate,
        );
        employeeResponse = await employeeRepository.updateEmployees(
          employeeData,
        );
      }

      employeeResponse.fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l,
            isSaving: false,
          ),
        ),
        (r) async {
          emit(
            state.copyWith(
              isSaved: true,
              isSaving: false,
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          isNameValid: isNameValid,
          isRoleValid: isRoleValid,
          isStartDateValid: isStartDateValid,
          isSaving: false,
          errorMessage: 'Please fill in all fields',
        ),
      );
    }
  }
}
