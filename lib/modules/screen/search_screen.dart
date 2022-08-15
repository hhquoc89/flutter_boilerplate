import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_state.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';
import 'package:flutter_boilerplate/modules/enviroment_screen.dart';
import 'package:flutter_boilerplate/routers/route_name.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/cubit/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.darkBlue,
            title: Center(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, RouteName.initial),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 30,
                  height: 40,
                  color: AppColors.darkBlue,
                ),
              ),
            ),
            // Text('Environment ${FlavorConfig.instance?.flavor.toString()}'),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const Icon(
                        Icons.person,
                        color: AppColors.white,
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (_) {},
                      items: <String>['Login', 'Sign Up', 'Setting']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
            ]),
        body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: AppColors.black,
                        ),
                      ),
                      hintText: 'Search'),
                ),
              )
            ],
          );
        }));
  }
}
