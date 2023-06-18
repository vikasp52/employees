// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:employees/features/employees/data/repository/employee_repository.dart';

part 'employees_state.dart';
part 'employees_cubit.freezed.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(
    this.employeeRepository,
  ) : super(const EmployeesState.loading()) {
    getEmployees();
  }

  final EmployeeRepository employeeRepository;

  Future<void> getEmployees() async {
    emit(const EmployeesState.loading());

    final employees = await employeeRepository.getEmployees();

    employees.fold(
      (l) => emit(EmployeesState.error(
        l,
      )),
      (r) async {
        emit(EmployeesState.loaded(r));
      },
    );
  }

  Future<void> deleteEmployees(
    Employee employee,
  ) async {
    emit(
      const EmployeesState.deleteInProgress(),
    );

    final validate = await employeeRepository.deleteEmployees(
      employee,
    );

    validate.fold(
      (l) => emit(
        EmployeesState.errorInDeleting(
          l,
        ),
      ),
      (r) async {
        emit(
          const EmployeesState.deletedSuccessfully(),
        );
      },
    );
  }
}
