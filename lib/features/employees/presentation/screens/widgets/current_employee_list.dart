import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:employees/features/employees/presentation/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CurrentEmployeeList extends StatelessWidget {
  const CurrentEmployeeList({
    super.key,
    required this.currentEmployees,
    required this.cubit,
  });

  final List<Employee> currentEmployees;
  final EmployeesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: currentEmployees.isEmpty
          ? const NoEmployeeFound()
          : Container(
              color: CustomColors.color12,
              child: EmployeeList(
                employees: currentEmployees,
                cubit: cubit,
              ),
            ),
    );
  }
}
