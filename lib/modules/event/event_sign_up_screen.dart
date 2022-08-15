import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';
import 'package:flutter_boilerplate/commons/utils/app_colors.dart';
import 'package:flutter_boilerplate/modules/appBar/appbar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Sign up for an account',
              style: appCubit.styles.customTextStyle3(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Signing up for an account is free and easy. Fill out the form below to get started. JavaScript is required to to continue.',
              style: appCubit.styles.themeData.textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            const Text(
              'Username',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password (4 characters minimum)',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password Confirm', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Email', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'By clicking the "Sign up" button below, I certify that I have read and agree to the TMDB terms of use and privacy policy.',
              style: appCubit.styles.themeData.textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.lightBlue,
                    )),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Cannel',
                    style: TextStyle(color: AppColors.lightBlue),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
