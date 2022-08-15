import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';
import 'package:flutter_boilerplate/routers/route_name.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                  onChanged: (value) {
                    switch (value) {
                      case "Login":
                        Navigator.pushNamed(context, RouteName.login);
                        break;
                    }
                    switch (value) {
                      case "Sign Up":
                        Navigator.pushNamed(context, RouteName.signUp);
                        break;
                    }
                    switch (value) {
                      case "Setting":
                        Navigator.pushNamed(context, RouteName.login);
                        break;
                    }
                  },
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
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.search);
              },
              icon: const Icon(Icons.search)),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
