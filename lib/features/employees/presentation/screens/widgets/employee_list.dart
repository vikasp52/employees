import 'package:employees/core/assets/assets.dart';
import 'package:employees/core/routing/routing.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    super.key,
    required this.employees,
    required this.cubit,
  });

  final List<Employee> employees;
  final EmployeesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return Column(
          children: [
            Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => RouteGenerator.pushName(
                      routeName: RouteGenerator.addEditEmployeeRoute,
                      argument: employee,
                    )?.then(
                      (value) {
                        if (value ?? false) {
                          cubit.getEmployees();
                        }
                      },
                    ),
                    backgroundColor: CustomColors.color1,
                    foregroundColor: CustomColors.color12,
                    icon: Icons.edit_square,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider.value(
                            value: cubit,
                            child: AlertDialog(
                              title: const Text('Delete Employee'),
                              content: const Text(
                                  'Are you sure you want to delete this employee'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                BlocConsumer<EmployeesCubit, EmployeesState>(
                                  buildWhen: (previous, current) =>
                                      current.maybeWhen(
                                    deleteInProgress: () => true,
                                    deletedSuccessfully: () => true,
                                    errorInDeleting: (message) => true,
                                    orElse: () => false,
                                  ),
                                  listener: (context, state) {
                                    state.maybeWhen(
                                      errorInDeleting: (message) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              message,
                                              style: CustomTypography
                                                  .snackBarMessage,
                                            ),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      deletedSuccessfully: () {
                                        cubit.getEmployees();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Employee data has been deleted',
                                              style: CustomTypography
                                                  .snackBarMessage,
                                            ),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      orElse: () {},
                                    );
                                  },
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      deleteInProgress: () => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: SizedBox(
                                          height: 25.h,
                                          width: 20.w,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5.w,
                                          ),
                                        ),
                                      ),
                                      orElse: () => TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          cubit.deleteEmployees(employee);
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
                    backgroundColor: CustomColors.color11,
                    foregroundColor: CustomColors.color12,
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
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.role ?? '',
                        style: CustomTypography.dropdownHint,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'From ${DateFormat('dd MMMM, yyyy').format(
                          DateTime.parse(
                            employee.startDate ?? '',
                          ),
                        )}',
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
    );
  }
}
