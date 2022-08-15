import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';
import 'package:flutter_boilerplate/routers/route_name.dart';

class PannelCommunity extends StatelessWidget {
  final String sourceImage;
  PannelCommunity({required this.sourceImage});
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Stack(
      children: <Widget>[
        Image.asset(sourceImage, fit: BoxFit.cover, height: 550),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Join Today', style: appCubit.styles.customTitlePanelDark()),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Get access to maintain your own custom personal lists, track what you\'ve seen and search and filter for what to watch next—regardless if it\'s in theatres, on TV or available on popular streaming services like ',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.signUp);
                },
                child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.sugarGrape,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Enjoy TMDB ad free',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Maintain a personal watchlist',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Filter by your subscribed streaming services and find something to watch',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Log the movies and TV shows you\'ve seen',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Build custom lists',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Contribute to and improve our database',
                style: appCubit.styles.customTextstyleCommunity(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
