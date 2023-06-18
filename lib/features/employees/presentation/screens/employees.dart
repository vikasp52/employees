import 'package:employees/core/assets/assets.dart';
import 'package:employees/core/routing/routing.dart';
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: CustomColors.color1,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.w,
            ),
          ),
        ),
        child: IconButton(
          onPressed: () => RouteGenerator.pushName(
            routeName: RouteGenerator.addEditEmployeeRoute,
          )?.then(
            (value) {
              if (value ?? false) {
                cubit.getEmployees();
              }
            },
          ),
          icon: const Icon(
            Icons.add,
            color: CustomColors.color12,
          ),
        ),
      ),
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
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (message) => Center(
              child: Text(
                message,
                style: CustomTypography.dropdownValue,
              ),
            ),
            loaded: (employees) {
              if (employees.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/no_employee_found.png',
                      ),
                      Text(
                        'No employee records found',
                        style: CustomTypography.notFoundLabel,
                      ),
                    ],
                  ),
                );
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
                  Padding(
                    padding: EdgeInsets.all(
                      20.h,
                    ),
                    child: Text(
                      'Current employees',
                      style: CustomTypography.headline,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: currentEmployees.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no_employee_found.png',
                                  height: 70.h,
                                ),
                                Text(
                                  'No employee records found',
                                  style: CustomTypography.notFoundLabel,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            color: CustomColors.color12,
                            child: EmployeeList(
                              employees: currentEmployees,
                              cubit: cubit,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      20.h,
                    ),
                    child: Text(
                      'Previous employees',
                      style: CustomTypography.headline,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: previousEmployees.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no_employee_found.png',
                                  height: 70.h,
                                ),
                                Text(
                                  'No employee records found',
                                  style: CustomTypography.notFoundLabel,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            color: CustomColors.color12,
                            child: EmployeeList(
                              employees: previousEmployees,
                              cubit: cubit,
                            ),
                          ),
                  ),
                  Expanded(
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
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.expand(),
          );
        },
      ),
    );
  }
}
