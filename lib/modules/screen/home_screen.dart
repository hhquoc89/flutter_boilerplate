import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';
import 'package:flutter_boilerplate/app/cubit/app_state.dart';
import 'package:flutter_boilerplate/modules/enviroment_screen.dart';
import 'package:flutter_boilerplate/modules/pannel/panel_banner.dart';
import 'package:flutter_boilerplate/modules/pannel/panel_community.dart';
import 'package:flutter_boilerplate/modules/pannel/pannel.dart';
import 'package:flutter_boilerplate/modules/pannel/pannel_dark.dart';
import 'package:flutter_boilerplate/modules/pannel/pannel_footer.dart';
import 'package:flutter_boilerplate/modules/pannel/pannel_leaderboard.dart';
import 'package:flutter_boilerplate/routers/route_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return ListView(
      children: [
        PannelBanner(
          sourceImage: 'assets/images/banner.jpg',
        ),
        Pannel(
          text: 'What\'s popular',
          listOption: const ['On TV', 'In Theater'],
        ),
        PannelDark(
          text: 'Last Trailers',
          listOption: const ['On TV', 'In Theater'],
        ),
        Pannel(
          text: 'Trending',
          listOption: const ['Today', 'This week'],
        ),
        PannelCommunity(
          sourceImage: 'assets/images/banner1.jpg',
        ),
        PannelLeaderBoard(),
        PannelFooter(),
        ElevatedButton(
            child: Text(
              'Event Details',
              style: appCubit.styles.defaultTextStyle(),
            ),
            onPressed: () =>
                {Navigator.pushNamed(context, RouteName.eventDetails)})
      ],
    );
  }
}
