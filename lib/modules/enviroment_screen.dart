import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_boilerplate/modules/appBar/appbar.dart';

import 'package:flutter_boilerplate/modules/screen/home_screen.dart';
import 'package:flutter_boilerplate/modules/screen/drawer_screen.dart';

import '../app/cubit/app_cubit.dart';
import '../routers/route_name.dart';

class EnvironmentScreen extends StatefulWidget {
  const EnvironmentScreen({Key? key}) : super(key: key);

  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  String? showValue = 'On TV';

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Scaffold(
      appBar: AppBarWidget(),
      body: HomeScreen(),
      drawer: const DrawerScreen(),
    );
  }
}
