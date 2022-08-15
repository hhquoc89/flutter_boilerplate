import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/cubit/app_cubit.dart';
import '../../commons/utils/app_colors.dart';

class PannelLeaderBoard extends StatelessWidget {
  const PannelLeaderBoard({Key? key}) : super(key: key);

  // required variable

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Text(
            'Leader Board',
            style: appCubit.styles.customTextStyle3(),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
              height: 150,
              width: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          'All Time Edits',
                          style: appCubit.styles.themeData.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: AppColors.orange,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Edits This Week',
                          style: appCubit.styles.themeData.textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
