import 'package:dartz/dartz.dart';
import 'package:employees/features/employees/data/data_source/data_source.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepository {
  final EmployeeLocalDataSource _employeeDataSource;
  EmployeeRepository(
    EmployeeLocalDataSource employeeDataSource,
  ) : _employeeDataSource = employeeDataSource;

  Future<Either<String, int>> saveEmployeeDetails(
    Employee employee,
  ) async {
    try {
      print('employee details: $employee');
      final id = await _employeeDataSource.saveEmployeeDetails(
        employee,
      );
      print('employee id: $id');
      return Right(id);
    } catch (error) {
      if (error is DatabaseException) {
        return Left(error.result.toString());
      } else {
        return const Left('Something went wrong');
      }
    }
  }

  Future<Either<String, List<Employee>>> getEmployees() async {
    try {
      final employees = await _employeeDataSource.getEmployees();

      return Right(employees);
    } catch (error) {
      if (error is DatabaseException) {
        return Left(error.result.toString());
      } else {
        return const Left('Something went wrong');
      }
    }
  }

  Future<Either<String, int>> deleteEmployees(
    Employee employee,
  ) async {
    print('employee DELETE: $employee');
    try {
      final employees = await _employeeDataSource.deleteEmployee(
        employee,
      );

      return Right(employees);
    } catch (error) {
      if (error is DatabaseException) {
        return Left(error.result.toString());
      } else {
        return const Left('Something went wrong');
      }
    }
  }

  Future<Either<String, int>> updateEmployees(
    Employee employee,
  ) async {
    print('employee update: $employee');
    try {
      final employees = await _employeeDataSource.updateEmployee(
        employee,
      );

      return Right(employees);
    } catch (error) {
      if (error is DatabaseException) {
        return Left(error.result.toString());
      } else {
        return const Left('Something went wrong');
      }
    }
  }
}
