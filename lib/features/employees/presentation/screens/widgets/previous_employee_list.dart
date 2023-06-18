import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:employees/features/employees/presentation/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PreviousEmployeeList extends StatelessWidget {
  const PreviousEmployeeList({
    super.key,
    required this.previousEmployees,
    required this.cubit,
  });

  final List<Employee> previousEmployees;
  final EmployeesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: previousEmployees.isEmpty
          ? const NoEmployeeFound()
          : Container(
              color: CustomColors.color12,
              child: EmployeeList(
                employees: previousEmployees,
                cubit: cubit,
              ),
            ),
    );
  }
}
