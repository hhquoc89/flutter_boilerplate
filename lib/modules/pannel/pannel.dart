import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/cubit/app_cubit.dart';
import '../../commons/utils/app_colors.dart';

class Pannel extends StatelessWidget {
  // required variable
  final String text;
  final List<String> listOption;
  Pannel({required this.text, required this.listOption});
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Container(
      alignment: Alignment.topLeft,
      height: 300,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            text,
            style: appCubit.styles.customTextStyle3(),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 31,
            width: 110,
            decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField<String>(
              alignment: Alignment.topLeft,
              decoration: InputDecoration.collapsed(
                  hintText: listOption.first,
                  hintStyle: appCubit.styles.customOption()),
              borderRadius: BorderRadius.circular(20),
              dropdownColor: AppColors.darkBlue,
              items: listOption.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: appCubit.styles.customOption(),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
