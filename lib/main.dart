import 'dart:io';

import 'package:movies_app/src/core/common_feature/data/data_sources/app_shared_prefs.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_snack_bar.dart';
import 'package:movies_app/src/core/styles/app_theme.dart';
import 'package:movies_app/src/core/translations/l10n.dart';
import 'package:movies_app/src/core/util/helper.dart';
import 'package:movies_app/src/core/util/injections.dart';
import 'package:movies_app/src/core/util/router.dart';
import 'package:movies_app/src/features/intro/presentation/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/features/movies/presentation/pages/movies_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjections();
  AppSnackBar.init();
  runApp(const App());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static void setLocale(BuildContext context, String newLocale) {
    _AppState state = context.findAncestorStateOfType()!;
    state.setState(() {
      state.locale = Locale(newLocale);
    });
    sl<AppSharedPrefs>().setLang(newLocale);
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      String newLocale = Helper.getLang();
      setState(() {
        locale = Locale(newLocale);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          useInheritedMediaQuery: false,
          title: 'Clinic',
          scaffoldMessengerKey: snackbarKey,
          onGenerateRoute: AppRouter.generateRoute,
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale("ar"),
            Locale("en"),
          ],
          home: child,
        );
      },
      child: const MoviesPage(),
    );
  }
}
