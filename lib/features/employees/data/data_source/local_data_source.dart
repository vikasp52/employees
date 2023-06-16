import 'package:employees/core/local_db/local_db.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:sqflite/sqflite.dart' as sql;

class EmployeeLocalDataSource {
  Future<int> saveEmployeeDetails(Employee employee) async {
    final db = await SQLHelper.db();

    final id = await db.insert(
      LocalDBConstants.tableName,
      employee.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<Employee>> getEmployees() async {
    final db = await SQLHelper.db();

    final employees = await db.query(
      LocalDBConstants.tableName,
    );

    return employees
        .map(
          (e) => Employee.fromJson(
            e,
          ),
        )
        .toList();
  }

  Future<int> updateEmployee(
    Employee employee,
  ) async {
    final db = await SQLHelper.db();

    final result = db.update(
      LocalDBConstants.tableName,
      employee.toJson(),
      where: '${LocalDBConstants.id}  = ?',
      whereArgs: [LocalDBConstants.id],
    );

    return result;
  }

  Future deleteEmployee(
    Employee employee,
  ) async {
    final db = await SQLHelper.db();

    db.delete(
      LocalDBConstants.tableName,
      where: '${LocalDBConstants.id}  = ?',
      whereArgs: [LocalDBConstants.id],
    );
  }
}
