import 'package:employees/core/assets/assets.dart';
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
  final _calendarFormat = CalendarFormat.month;
  final firstDay = DateTime.utc(2010, 10, 16);
  final lastDay = DateTime.utc(2030, 3, 14);
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDate;

  // void selectToday() {
  //   setState(() {
  //     _selectedDate = DateTime.now();
  //     _focusedDay = _selectedDate ?? DateTime.now();
  //   });
  // }

  // void selectNextMonday() {
  //   setState(() {
  //     _selectedDate = _getNextWeekday(DateTime.now(), DateTime.monday);
  //     _focusedDay = _selectedDate ?? DateTime.now();
  //   });
  // }

  // void selectNextTuesday() {
  //   setState(() {
  //     _selectedDate = _getNextWeekday(DateTime.now(), DateTime.tuesday);
  //     _focusedDay = _selectedDate ?? DateTime.now();
  //   });
  // }

  // DateTime _getNextWeekday(DateTime date, int weekday) {
  //   final daysUntilNextWeekday = (weekday - date.weekday + 7) % 7;
  //   return date.add(Duration(days: daysUntilNextWeekday));
  // }

  // void selectAfterOneWeek() {
  //   setState(() {
  //     _selectedDate = _selectedDate?.add(
  //       const Duration(
  //         days: 7,
  //       ),
  //     );
  //     _focusedDay = _selectedDate ?? DateTime.now();
  //   });
  // }

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
          if (!state.isNameValid || !state.isRoleValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Please fill in all fields',
                  style: CustomTypography.snackBarMessage,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) => cubit.updateName(
                        value.trim(),
                      ),
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
                                          onTap: () {
                                            cubit.updateRole(e);
                                            Navigator.pop(context);
                                          },
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
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                  value: cubit,
                                  child: Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        18.w,
                                      ),
                                    ),
                                    child: Column(
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
                                                  onPressed: () {
                                                    cubit.selectToday();
                                                    Navigator.pop(context);
                                                  },
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
                                                  onPressed: () {
                                                    cubit.selectNextMonday();
                                                    Navigator.pop(context);
                                                  },
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
                                                  onPressed: () {
                                                    cubit.selectNextTuesday();
                                                    Navigator.pop(context);
                                                  },
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
                                                  onPressed: () {
                                                    cubit.selectAfterOneWeek();
                                                    Navigator.pop(context);
                                                  },
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
                                        BlocBuilder<AddEditEmployeeCubit,
                                            AddEditEmployeeState>(
                                          builder: (context, state) {
                                            return TableCalendar(
                                              firstDay: firstDay,
                                              lastDay: lastDay,
                                              focusedDay:
                                                  state.startDate.isEmpty
                                                      ? DateTime.now()
                                                      : DateTime.parse(
                                                          state.startDate),
                                              calendarFormat: _calendarFormat,
                                              selectedDayPredicate: (day) {
                                                // Use `selectedDayPredicate` to determine which day is currently selected.
                                                // If this returns true, then `day` will be marked as selected.

                                                // Using `isSameDay` is recommended to disregard
                                                // the time-part of compared DateTime objects.

                                                print(
                                                    'state.startDate: ${state.startDate.isEmpty}');
                                                return isSameDay(
                                                    state.startDate.isEmpty
                                                        ? DateTime.now()
                                                        : DateTime.parse(
                                                            state.startDate),
                                                    day);
                                              },
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
                                                cubit.selectDate(
                                                  selectedDay: selectedDay,
                                                );
                                              },
                                              headerStyle: HeaderStyle(
                                                titleCentered: true,
                                                headerPadding: EdgeInsets.only(
                                                  bottom: 20.h,
                                                ),
                                                rightChevronMargin:
                                                    EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                ),
                                                leftChevronMargin:
                                                    EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                ),
                                                leftChevronIcon: const Icon(
                                                  Icons.arrow_left_rounded,
                                                  color: CustomColors.color7,
                                                ),
                                                rightChevronIcon: const Icon(
                                                  Icons.arrow_right_rounded,
                                                  color: CustomColors.color7,
                                                ),
                                                rightChevronPadding:
                                                    EdgeInsets.zero,
                                                titleTextStyle: CustomTypography
                                                    .notFoundLabel,
                                                formatButtonVisible: false,
                                              ),
                                              calendarStyle:
                                                  const CalendarStyle(
                                                outsideDaysVisible: false,
                                                // todayDecoration: BoxDecoration(
                                                //   color: CustomColors.color1,
                                                //   borderRadius:
                                                //       BorderRadius.all(
                                                //     Radius.circular(50.w),
                                                //   ),
                                                // ),
                                                selectedDecoration:
                                                    BoxDecoration(
                                                  color: CustomColors.color1,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            );
                                          },
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
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
                                    ),
                                  ),
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
