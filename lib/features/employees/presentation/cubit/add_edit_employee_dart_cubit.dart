// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/data/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_employee_dart_state.dart';
part 'add_edit_employee_dart_cubit.freezed.dart';

class AddEditEmployeeDartCubit extends Cubit<AddEditEmployeeDartState> {
  AddEditEmployeeDartCubit(
    this.employeeRepository,
  ) : super(
          const AddEditEmployeeDartState.innitial(),
        );

  final EmployeeRepository employeeRepository;

  Future<void> addEmployee(
    Employee employee,
  ) async {
    emit(const AddEditEmployeeDartState.savingDetailsInProgress());

    final validate = await employeeRepository.saveEmployeeDetails(
      employee,
    );

    validate.fold(
      (l) => emit(
        AddEditEmployeeDartState.error(
          l,
        ),
      ),
      (r) async {
        emit(
          const AddEditEmployeeDartState.saved(),
        );
      },
    );
  }
}
