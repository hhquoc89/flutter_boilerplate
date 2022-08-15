import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/cubit/app_cubit.dart';
import '../../commons/utils/app_colors.dart';

class PannelFooter extends StatelessWidget {
  const PannelFooter({Key? key}) : super(key: key);

  // required variable
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Container(
      padding: const EdgeInsets.all(25),
      color: AppColors.darkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                'JOIN THE COMMUNITY',
                style: appCubit.styles.customTitleButtonFooter(),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.white,
              )),
          SizedBox(
            height: 50,
          ),
          Text(
            'THE BASICS',
            style: appCubit.styles.customTitleFooter(),
          ),
          Text(
            'About TMDB',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Contact Us',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Support Forums',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'API',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'GET INVOLVED',
            style: appCubit.styles.customTitleFooter(),
          ),
          Text(
            'Contribute Bible',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Add A New Movie',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Add New TV Show ',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'COMMUNITY',
            style: appCubit.styles.customTitleFooter(),
          ),
          Text(
            'Guildelines',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Discussions',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Leader board',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Twitter',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'LEGAL',
            style: appCubit.styles.customTitleFooter(),
          ),
          Text(
            'Terms of Use',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'API Terms of Use',
            style: appCubit.styles.customHeadLineFooter(),
          ),
          Text(
            'Privacy Policy',
            style: appCubit.styles.customHeadLineFooter(),
          ),
        ],
      ),
    );
  }
}
