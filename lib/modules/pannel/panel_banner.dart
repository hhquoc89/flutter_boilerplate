import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app/cubit/app_cubit.dart';

class PannelBanner extends StatelessWidget {
  final String sourceImage;
  PannelBanner({
    required this.sourceImage,
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(sourceImage, fit: BoxFit.cover, height: 360),
        Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text('Welcome.', style: appCubit.styles.customTextStyle1()),
                Text(
                  'Millions of movies,TV shows and people to discover. Explore now.',
                  style: appCubit.styles.customTextStyle2(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
