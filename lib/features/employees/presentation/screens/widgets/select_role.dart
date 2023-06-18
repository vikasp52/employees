import 'package:employees/features/employees/presentation/cubit/add_edit_employee_dart_cubit.dart';
import 'package:flutter/material.dart';

class SelectRole extends StatelessWidget {
  const SelectRole({
    super.key,
    required this.cubit,
  });

  final AddEditEmployeeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}
