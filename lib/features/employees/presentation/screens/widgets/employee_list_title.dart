import 'package:employees/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeListTitle extends StatelessWidget {
  const EmployeeListTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        20.h,
      ),
      child: Text(
        title,
        style: CustomTypography.headline,
      ),
    );
  }
}
