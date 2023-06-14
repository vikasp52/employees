import 'package:employees/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditEmployee extends StatelessWidget {
  const AddEditEmployee({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  child: const Text(
                    'Save',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
