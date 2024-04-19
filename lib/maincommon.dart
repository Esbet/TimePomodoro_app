import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/routes/page_generator.dart';
import 'core/theme/app_theme.dart';
import 'features/time/presentation/pages/splash_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TimePomodoro',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: appTheme,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: PageClassGenerator.getNamedScreen,
      );
    });
  }
}
