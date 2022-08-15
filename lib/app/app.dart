import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../localizations/app_localization.dart';
import '../routers/route_name.dart';
import '../routers/routes.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_state.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final Routes routes = Routes();
  late AppCubit appCubit;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    appCubit = AppCubit(AppInitial());
    appCubit.initInterceptors();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => appCubit),
      ],
      child: GestureDetector(
        onTap: () {
          //Hide keyboard when tap outside
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        },
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp(
              locale: (state is AppLanguageFetchLocaleCompleted)
                  ? state.locale
                  : const Locale('en'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              theme: context.read<AppCubit>().styles.themeData,
              initialRoute: RouteName.event,
              onGenerateRoute: routes.routePage,
            );
          },
        ),
      ),
    );
  }
}
