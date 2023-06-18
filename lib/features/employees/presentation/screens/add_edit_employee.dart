import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/presentation/cubit/add_edit_employee_dart_cubit.dart';
import 'package:employees/features/employees/presentation/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AddEditEmployee extends StatefulWidget {
  const AddEditEmployee({super.key});

  @override
  State<AddEditEmployee> createState() => _AddEditEmployeeState();
}

class _AddEditEmployeeState extends State<AddEditEmployee> {
  final _calendarFormat = CalendarFormat.month;
  final firstDay = DateTime.utc(2010, 10, 16);
  final lastDay = DateTime.utc(2030, 3, 14);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditEmployeeCubit>();
    return Scaffold(
      backgroundColor: CustomColors.color12,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Employee Details',
          style: CustomTypography.titleWhite,
        ),
      ),
      body: BlocConsumer<AddEditEmployeeCubit, AddEditEmployeeState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage!,
                  style: CustomTypography.snackBarMessage,
                ),
              ),
            );
          }

          if (state.isSaved) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => cubit.updateName(
                        value.trim(),
                      ),
                      initialValue:
                          cubit.employee != null ? cubit.employee!.name : null,
                      decoration: const InputDecoration(
                        hintText: 'Employee name',
                        // errorText:
                        //     state.isNameValid ? null : 'Please enter a name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: CustomColors.color1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.color10,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.w),
                                topRight: Radius.circular(20.w),
                              ),
                            ),
                            builder: (context) => SelectRole(
                              cubit: cubit,
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 40.w,
                          color: CustomColors.color1,
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 14.w,
                              ),
                              child: const Icon(
                                Icons.cases_outlined,
                                color: CustomColors.color1,
                              ),
                            ),
                            Text(
                              state.role.isEmpty ? 'Select role' : state.role,
                              style: state.role.isEmpty
                                  ? CustomTypography.textFieldHint
                                  : CustomTypography.textFieldValue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        _buildStartDate(
                          context,
                          cubit,
                          state,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: CustomColors.color1,
                          ),
                        ),
                        _buildEndDate(
                          context,
                          cubit,
                          state,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(),
              _buildSaveCancelButton(
                context,
                state,
                cubit,
              ),
            ],
          );
        },
      ),
    );
  }

  Padding _buildSaveCancelButton(
    BuildContext context,
    AddEditEmployeeState state,
    AddEditEmployeeCubit cubit,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          state.isSaving
              ? SizedBox(
                  height: 35.h,
                  width: 25.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5.w,
                  ),
                )
              : ElevatedButton(
                  onPressed: () => cubit.addEmployee(),
                  child: const Text(
                    'Save',
                  ),
                ),
        ],
      ),
    );
  }

  Expanded _buildEndDate(BuildContext context, AddEditEmployeeCubit cubit,
      AddEditEmployeeState state) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        onTap: () => showDialog(
          context: context,
          builder: (context) => SelectDateDialog(
            cubit: cubit,
            firstDay: firstDay,
            lastDay: lastDay,
            isStartDate: false,
            calendarFormat: _calendarFormat,
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: CustomColors.color1,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              state.endDate == null
                  ? 'No Date'
                  : DateFormat('dd MMMM yyyy').format(
                      DateTime.parse(
                        state.endDate ?? '',
                      ),
                    ),
              style: state.startDate.isEmpty
                  ? CustomTypography.textFieldHint
                  : CustomTypography.textFieldValue,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: CustomColors.color10,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Expanded _buildStartDate(
    BuildContext context,
    AddEditEmployeeCubit cubit,
    AddEditEmployeeState state,
  ) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => SelectDateDialog(
            cubit: cubit,
            firstDay: firstDay,
            lastDay: lastDay,
            calendarFormat: _calendarFormat,
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: CustomColors.color1,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              state.startDate.isEmpty
                  ? 'No Date'
                  : DateFormat('dd MMMM yyyy').format(
                      DateTime.parse(
                        state.startDate,
                      ),
                    ),
              style: state.startDate.isEmpty
                  ? CustomTypography.textFieldHint
                  : CustomTypography.textFieldValue,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: CustomColors.color10,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
