import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/cubit/app_cubit.dart';
import '../../commons/utils/app_colors.dart';

class PannelDark extends StatelessWidget {
  // required variable
  final String text;
  List<String> listOption = [];
  PannelDark({required this.text, required this.listOption});
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppColors.darkBlue,
      child: Row(
        children: [
          Text(
            text,
            style: appCubit.styles.customTitlePanelDark(),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 31,
            width: 110,
            decoration: BoxDecoration(
                color: AppColors.mintJelly,
                borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField<String>(
              alignment: Alignment.topLeft,
              decoration: InputDecoration.collapsed(
                  hintText: listOption.first,
                  hintStyle: appCubit.styles.customOptionDark()),
              borderRadius: BorderRadius.circular(20),
              dropdownColor: AppColors.mintJelly,
              items: listOption.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: appCubit.styles.customOptionDark(),
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
