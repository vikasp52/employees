import 'package:employees/core/di/inection_container.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/data/repository/repository.dart';
import 'package:employees/features/employees/presentation/cubit/add_edit_employee_dart_cubit.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:employees/features/employees/presentation/screens/add_edit_employee.dart';
import 'package:employees/features/employees/presentation/screens/employees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static const String initialRoute = '/';
  static const String addEditEmployeeRoute = '/AddEditEmployee';
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic>? pushName<Argument>(
      {required String routeName, Argument? argument}) {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: argument,
    );
  }

  static Future<dynamic>? pushReplacement<Argument>(
      {required String routeName, Argument? argument}) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: argument,
    );
  }

  static Future<dynamic>? pushAndRemoveUntil<Argument>(
      {required String routeName}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    late Widget screen;

    switch (routeSettings.name) {
      case initialRoute:
        screen = BlocProvider(
          create: (context) => EmployeesCubit(
            serviceLocator<EmployeeRepository>(),
          ),
          child: const Employees(),
        );
        break;
      case addEditEmployeeRoute:
        screen = BlocProvider(
          create: (context) => AddEditEmployeeDartCubit(
            serviceLocator<EmployeeRepository>(),
          ),
          child: const AddEditEmployee(),
        );
        break;

      default:
        screen = const Scaffold(
          body: Center(
            child: Text(
              'Invalid Route',
            ),
          ),
        );
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
