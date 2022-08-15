import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: AppColors.darkBlue,
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 20),
            child: Container(
              height: 540,
              child: ListView(
                children: [
                  Text(
                    'Movies',
                    style: appCubit.styles.customTextStyle5(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Popular',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Top Rated',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Upcoming',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Now Playing',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'TV Shows',
                    style: appCubit.styles.customTextStyle5(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Popular',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Top Rated',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'On TV',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Airing Today',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'People',
                    style: appCubit.styles.customTextStyle5(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Popular People',
                    style: appCubit.styles.customTextStyle6(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Contribution Bible',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Apps',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Discussion',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Leader Board',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Contribute',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'API',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Support',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'About',
                    style: appCubit.styles.customTextStyleGrey6(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        'Log in',
                        style: appCubit.styles.customTextStyleGrey6(),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
