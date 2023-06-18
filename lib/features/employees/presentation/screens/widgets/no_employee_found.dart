import 'package:employees/core/assets/assets.dart';
import 'package:flutter/material.dart';

class EmployeeNotFound extends StatelessWidget {
  const EmployeeNotFound({
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
