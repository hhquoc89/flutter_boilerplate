import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';
import 'package:flutter_boilerplate/modules/appBar/appbar.dart';
import 'package:flutter_boilerplate/modules/login/bloc/login_bloc.dart';
import 'package:flutter_boilerplate/routers/route_name.dart';

import '../respositories/repositories.dart';

class LoginForm extends StatefulWidget {
  final UserRepositories userRepositories;
  const LoginForm({Key? key, required this.userRepositories})
      : assert(userRepositories != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepositories);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepositories userRepositories;
  _LoginFormState(UserRepositories this.userRepositories);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          userName: userNameController.text,
          password: passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Login failed."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      String _token;
      return Form(
        key: _formKey,
        child: Scaffold(
          appBar: const AppBarWidget(),
          body: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'Login to your account',
                  style: appCubit.styles.customTextStyle3(),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(
                        style: appCubit.styles.defaultTextStyle(),
                        children: [
                      const TextSpan(
                          text:
                              'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.'),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RouteName.signUp);
                            },
                          text: ' Click here ',
                          style: const TextStyle(color: AppColors.lightBlue)),
                      const TextSpan(text: 'to get started.')
                    ])),
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                        style: appCubit.styles.defaultTextStyle(),
                        children: [
                      const TextSpan(
                          text:
                              'If you signed up but didn\'t get your verification email,'),
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: ' Click here ',
                          style: const TextStyle(color: AppColors.lightBlue)),
                      const TextSpan(text: 'to have it resent.')
                    ])),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Password ', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (password) {
                    if (password!.isEmpty) {
                      return "Enter the valid password";
                    }
                    if (password.length <= 4) {
                      return "Password must have at least 4 character";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _onLoginButtonPressed();
                        },
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.lightBlue,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(color: AppColors.lightBlue),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
