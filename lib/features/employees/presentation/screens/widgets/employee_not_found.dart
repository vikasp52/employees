import 'package:employees/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoEmployeeFound extends StatelessWidget {
  const NoEmployeeFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
