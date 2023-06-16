import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/data/model/employee.dart';
import 'package:employees/features/employees/presentation/cubit/add_edit_employee_dart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class AddEditEmployee extends StatefulWidget {
  const AddEditEmployee({super.key});

  @override
  State<AddEditEmployee> createState() => _AddEditEmployeeState();
}

class _AddEditEmployeeState extends State<AddEditEmployee> {
  final _employeeName = TextEditingController();

  @override
  void dispose() {
    _employeeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditEmployeeDartCubit>();
    return Scaffold(
      backgroundColor: CustomColors.color12,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Employee Details',
          style: CustomTypography.titleWhite,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Employee name',
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
                        builder: (context) => Wrap(
                          children: [
                            'Product Designer',
                            'Flutter Developer',
                            'QA Tester',
                            'Product Owner'
                          ]
                              .map(
                                (e) => Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              )
                              .toList(),
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
                          'Select role',
                          style: CustomTypography.textFieldHint,
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
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  18.w,
                                ),
                              ),
                              child: const CalendarPopUp(),
                            ),
                          );
                        },
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
                              'Today',
                              style: CustomTypography.textFieldValue,
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
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
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
                              'No Date',
                              style: CustomTypography.textFieldHint,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          Padding(
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
                ElevatedButton(
                  onPressed: () {
                    cubit.addEmployee(
                      const Employee(
                        name: 'Vikas',
                        role: 'Software developer',
                        startDate: 'dsdsd',
                      ),
                    );
                  },
                  child: const Text(
                    'Save',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarPopUp extends StatelessWidget {
  const CalendarPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20.w,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Today',
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Next Monday',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Next Tuesday',
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'After 1 week',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          headerStyle: HeaderStyle(
            titleCentered: true,
            headerPadding: EdgeInsets.only(
              bottom: 20.h,
            ),
            rightChevronMargin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 5,
            ),
            leftChevronMargin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 5,
            ),
            leftChevronIcon: const Icon(
              Icons.arrow_left_rounded,
              color: CustomColors.color7,
            ),
            rightChevronIcon: const Icon(
              Icons.arrow_right_rounded,
              color: CustomColors.color7,
            ),
            rightChevronPadding: EdgeInsets.zero,
            titleTextStyle: CustomTypography.notFoundLabel,
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
              color: CustomColors.color1,
              borderRadius: BorderRadius.all(
                Radius.circular(50.w),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
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
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Save',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
