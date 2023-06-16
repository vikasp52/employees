import 'package:employees/core/assets/assets.dart';
import 'package:employees/core/routing/routing.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            orElse: () => false),
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
                            child: ListView.builder(
                              itemCount: currentEmployees.length,
                              itemBuilder: (context, index) {
                                final employee = employees[index];
                                return Column(
                                  children: [
                                    Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {},
                                            backgroundColor:
                                                CustomColors.color1,
                                            foregroundColor:
                                                CustomColors.color12,
                                            icon: Icons.edit_square,
                                            label: 'Edit',
                                          ),
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BlocProvider.value(
                                                    value: cubit,
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          'Delete Employee'),
                                                      content: const Text(
                                                          'Are you sure you want to delete this employee'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                        BlocConsumer<
                                                            EmployeesCubit,
                                                            EmployeesState>(
                                                          buildWhen: (previous,
                                                                  current) =>
                                                              current.maybeWhen(
                                                            deleteInProgress:
                                                                () => true,
                                                            deletedSuccessfully:
                                                                () => true,
                                                            errorInDeleting:
                                                                (message) =>
                                                                    true,
                                                            orElse: () => false,
                                                          ),
                                                          listener:
                                                              (context, state) {
                                                            state.maybeWhen(
                                                              errorInDeleting:
                                                                  (message) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      message,
                                                                      style: CustomTypography
                                                                          .snackBarMessage,
                                                                    ),
                                                                  ),
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              deletedSuccessfully:
                                                                  () {
                                                                cubit
                                                                    .getEmployees();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Employee data has been deleted',
                                                                      style: CustomTypography
                                                                          .snackBarMessage,
                                                                    ),
                                                                  ),
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              orElse: () {},
                                                            );
                                                          },
                                                          builder:
                                                              (context, state) {
                                                            return state
                                                                .maybeWhen(
                                                              deleteInProgress:
                                                                  () => Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            30.w),
                                                                child: SizedBox(
                                                                  height: 25.h,
                                                                  width: 20.w,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2.5.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              orElse: () =>
                                                                  TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed: () {
                                                                  cubit.deleteEmployees(
                                                                      employee);
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            backgroundColor:
                                                CustomColors.color11,
                                            foregroundColor:
                                                CustomColors.color12,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          employee.name ?? '',
                                          style: CustomTypography.subTitle,
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Full-stack Developer',
                                                style: CustomTypography
                                                    .dropdownHint,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                '1 Jul, 2022 - 22 Dec, 2023',
                                                style: CustomTypography.date,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
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
                            child: ListView.builder(
                              itemCount: previousEmployees.length,
                              itemBuilder: (context, index) {
                                final employee = previousEmployees[index];
                                return Container(
                                  color: CustomColors.color12,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          employee.name ?? '',
                                          style: CustomTypography.subTitle,
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Full-stack Developer',
                                                style: CustomTypography
                                                    .dropdownHint,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                '1 Jul, 2022 - 22 Dec, 2023',
                                                style: CustomTypography.date,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              },
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
