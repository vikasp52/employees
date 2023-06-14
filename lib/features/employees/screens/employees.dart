import 'package:employees/core/assets/assets.dart';
import 'package:employees/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: CustomTypography.titleWhite,
        ),
      ),
      body: Column(
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
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                color: CustomColors.color12,
                child: Column(
                  children: [
                    Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: CustomColors.color1,
                            foregroundColor: CustomColors.color12,
                            icon: Icons.edit_square,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: CustomColors.color11,
                            foregroundColor: CustomColors.color12,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Samantha Lee',
                          style: CustomTypography.subTitle,
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full-stack Developer',
                                style: CustomTypography.dropdownHint,
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
                ),
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
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                color: CustomColors.color12,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Samantha Lee',
                        style: CustomTypography.subTitle,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full-stack Developer',
                              style: CustomTypography.dropdownHint,
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
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                children: [
                  Text(
                    'Swipe left to delete',
                    style: CustomTypography.swipeLabel,
                  ),
                  const Spacer(),
                  Container(
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
