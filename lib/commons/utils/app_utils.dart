import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';
import '../../localizations/app_localization.dart';

class AppUtils {
  static AppCubit getAppCubit(BuildContext context) {
    return getCubit<AppCubit>(context);
  }

  static AppLocalizations getAppLocale(BuildContext context) =>
      AppLocalizations.of(context);

  static T getCubit<T extends Cubit>(BuildContext context) => context.read<T>();
}
