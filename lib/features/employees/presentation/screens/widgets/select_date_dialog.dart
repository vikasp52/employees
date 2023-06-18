import 'package:employees/core/assets/assets.dart';
import 'package:employees/features/employees/presentation/cubit/add_edit_employee_dart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateDialog extends StatelessWidget {
  const SelectDateDialog({
    super.key,
    required this.cubit,
    required this.firstDay,
    required this.lastDay,
    this.isStartDate = true,
    required CalendarFormat calendarFormat,
  }) : _calendarFormat = calendarFormat;

  final AddEditEmployeeCubit cubit;
  final DateTime firstDay;
  final DateTime lastDay;
  final CalendarFormat _calendarFormat;
  final bool isStartDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
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
                        cubit.selectToday(
                          isStartDate: isStartDate,
                        );
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
                        cubit.selectNextMonday(
                          isStartDate: isStartDate,
                        );
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
                        cubit.selectNextTuesday(
                          isStartDate: isStartDate,
                        );
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
                        cubit.selectAfterOneWeek(
                          isStartDate: isStartDate,
                        );
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
            BlocBuilder<AddEditEmployeeCubit, AddEditEmployeeState>(
              builder: (context, state) {
                return TableCalendar(
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: state.startDate.isEmpty
                      ? DateTime.now()
                      : DateTime.parse(state.startDate),
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    if (isStartDate) {
                      return isSameDay(
                          state.startDate.isEmpty
                              ? DateTime.now()
                              : DateTime.parse(state.startDate),
                          day);
                    }
                    return isSameDay(
                      state.endDate == null
                          ? DateTime.now()
                          : state.endDate!.isEmpty
                              ? DateTime.now()
                              : DateTime.parse(state.endDate!),
                      day,
                    );
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    cubit.selectDate(
                      selectedDay: selectedDay,
                      isStartDate: isStartDate,
                    );
                  },
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
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
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
                  BlocBuilder<AddEditEmployeeCubit, AddEditEmployeeState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (isStartDate && state.startDate.isEmpty) {
                            cubit.selectDatePress(
                              isStartDate: isStartDate,
                            );
                          }

                          if (state.endDate == null && !isStartDate) {
                            cubit.selectDatePress(
                              isStartDate: isStartDate,
                            );
                          }

                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
