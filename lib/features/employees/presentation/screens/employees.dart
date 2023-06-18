import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:employees/features/employees/presentation/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeesCubit>();
    return Scaffold(
      floatingActionButton: AddEmployeeButton(cubit: cubit),
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: CustomTypography.titleWhite,
        ),
      ),
      body: BlocBuilder<EmployeesCubit, EmployeesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          loading: () => true,
          loaded: (employee) => true,
          error: (message) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => _buildProgressIndicator(),
            error: (message) => _buildErrorMessage(message),
            loaded: (employees) {
              if (employees.isEmpty) {
                return const EmployeeNotFound();
              }

              final currentEmployees = employees
                  .where((employee) => employee.endDate == null)
                  .toList();
              final previousEmployees = employees
                  .where((employee) => employee.endDate != null)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EmployeeListTitle(
                    title: 'Current employees',
                  ),
                  CurrentEmployeeList(
                    currentEmployees: currentEmployees,
                    cubit: cubit,
                  ),
                  const EmployeeListTitle(
                    title: 'Previous employees',
                  ),
                  PreviousEmployeeList(
                    previousEmployees: previousEmployees,
                    cubit: cubit,
                  ),
                  _buildSwipe(),
                ],
              );
            },
            orElse: () => const SizedBox.expand(),
          );
        },
      ),
    );
  }

  Expanded _buildSwipe() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 14.h,
        ),
        child: Text(
          'Swipe left to delete',
          textAlign: TextAlign.start,
          style: CustomTypography.swipeLabel,
        ),
      ),
    );
  }

  Center _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: CustomTypography.dropdownValue,
      ),
    );
  }
}
