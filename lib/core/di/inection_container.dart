import 'package:employees/features/employees/data/data_source/data_source.dart';
import 'package:employees/features/employees/data/repository/repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.I;
Future<void> setUp() async {
  serviceLocator.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepository(
      EmployeeLocalDataSource(),
    ),
  );
}
