// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/data/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_employee_dart_state.dart';
part 'add_edit_employee_dart_cubit.freezed.dart';

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  AddEditEmployeeCubit(
    this.employeeRepository,
  ) : super(AddEditEmployeeState.initial());

  final EmployeeRepository employeeRepository;

  void updateName(String name) {
    emit(
      state.copyWith(
        name: name,
      ),
    );
  }

  void updateRole(String role) {
    emit(
      state.copyWith(
        role: role,
      ),
    );
  }

  void updatestartDate(String date) {
    emit(
      state.copyWith(
        startDate: date,
      ),
    );
  }

  void updateendDate(String date) {
    emit(
      state.copyWith(endDate: date),
    );
  }

  void selectDate({
    required DateTime? selectedDay,
    bool isStartDate = true,
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

  void selectToday({
    bool isStartDate = true,
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
    bool isStartDate = true,
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
    bool isStartDate = true,
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
    bool isStartDate = true,
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

      final employee = Employee(
        name: state.name,
        role: state.role,
        startDate: state.startDate,
        endDate: state.endDate,
      );
      final employeeDetails = await employeeRepository.saveEmployeeDetails(
        employee,
      );

      employeeDetails.fold(
        (l) => emit(
          state.copyWith(
            errorMessage: l,
          ),
        ),
        (r) async {
          emit(
            state.copyWith(
              isSaved: true,
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
