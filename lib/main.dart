import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';

import 'di/dependency_injection.dart';
import 'firebase_options.dart';
import 'presentation/core/auth/auth_bloc.dart';
import 'presentation/core/date/date_bloc.dart';
import 'presentation/core/settings/settings_bloc.dart';
import 'presentation/resources/resources.dart';
import 'presentation/routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _appRouter = AppRouter();
  final _authBloc = sl<AuthBloc>();
  final _dateBloc = sl<DateBloc>();
  final _settingsBloc = sl<SettingsBloc>();

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _authBloc..add(AuthStatusRequested()),
        ),
        BlocProvider.value(
          value: _settingsBloc
            ..add(GetUserAccounts())
            ..add(GetUserCategories())
            ..add(GetUserBudgets()),
        ),
        BlocProvider.value(
          value: _dateBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Mofi App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        theme: AppTheme.light,
        home: WillPopScope(
          child: Navigator(
            key: _navigatorKey,
            onGenerateRoute: _appRouter.routes,
          ),
          onWillPop: () async =>
              !(await _navigatorKey.currentState!.maybePop()),
        ),
      ),
    );
  }
}
