import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/modules/enviroment_screen.dart';
import 'package:flutter_boilerplate/modules/respositories/repositories.dart';
import 'package:flutter_boilerplate/modules/screen/login_screen.dart';
import 'package:flutter_boilerplate/modules/screen/search_screen.dart';
import 'package:flutter_boilerplate/modules/event/event_sign_up_screen.dart';

import '../../routers/route_name.dart';
import '../../routers/routes.dart';

import '../structure_testing_screen/structure_testing_screen.dart';

class EventRoutes implements RouteInterface {
  get userRepositories => null;

  @override
  CupertinoPageRoute routePage(RouteSettings settings) {
    return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case RouteName.event:
              return const EnvironmentScreen();
            case RouteName.eventDetails:
              return const StructureTestingScreen();
            case RouteName.search:
              return const SearchScreen();
            case RouteName.login:
              return LoginScreen(userRepositories: userRepositories);
            case RouteName.signUp:
              return const SignUpScreen();
            default:
              return Container();
          }
        });
  }
}
