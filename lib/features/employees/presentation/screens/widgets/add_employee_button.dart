import 'package:employees/core/assets/assets.dart';
import 'package:employees/core/routing/routing.dart';
import 'package:employees/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeeButton extends StatelessWidget {
  const AddEmployeeButton({
    super.key,
    required this.cubit,
  });

  final EmployeesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        )?.then(
          (value) {
            if (value ?? false) {
              cubit.getEmployees();
            }
          },
        ),
        icon: const Icon(
          Icons.add,
          color: CustomColors.color12,
        ),
      ),
    );
  }
}
