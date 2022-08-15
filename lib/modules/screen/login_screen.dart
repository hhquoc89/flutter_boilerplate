import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_boilerplate/modules/login/bloc/login_bloc.dart';
import 'package:flutter_boilerplate/modules/login/login_form.dart';
import 'package:flutter_boilerplate/modules/respositories/repositories.dart';

class LoginScreen extends StatelessWidget {
  final UserRepositories userRepositories;
  const LoginScreen({
    Key? key,
    required this.userRepositories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepositories: userRepositories,
          );
        },
        child: LoginForm(
          userRepositories: userRepositories,
        ),
      ),
    );
  }
}
