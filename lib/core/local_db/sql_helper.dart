import 'package:employees/core/local_db/local_db.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute(
      '''CREATE TABLE ${LocalDBConstants.tableName}(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${LocalDBConstants.name} TEXT,
      ${LocalDBConstants.role} TEXT,
      ${LocalDBConstants.startDate} TEXT,
      ${LocalDBConstants.endDate} TEXT
    )''',
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbemployee.db',
      version: 1,
      onCreate: (db, version) async => createTable(db),
    );
  }
}
