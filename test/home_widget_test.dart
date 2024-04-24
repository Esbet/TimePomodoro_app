import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/theme/app_theme.dart';
import 'package:timepomodoro_app/core/utils/keys.dart';
import 'package:timepomodoro_app/features/time/presentation/pages/home_page.dart';
import 'package:timepomodoro_app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('AuthPage widget tests', () {
    late Widget testApp;
    setUpAll(() async {
      await injectDependencies();

      testApp = ResponsiveSizer(
        builder: (context, orientation, screenType) {
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
              home: HomePage());
        },
      );
    });

    testWidgets('Time update test', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      expect(find.text('25:00'), findsOneWidget);
      await tester.tap(find.byKey(Keys.initButton));
      await tester.pump();
    });

    testWidgets('Button text changes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      expect(find.text('Start'), findsOneWidget);
      await tester.tap(find.byKey(Keys.initButton));
      await tester.pump(); 
      expect(find.text('Stop'), findsOneWidget);
    });

    testWidgets('Time displayed changes when selecting different options',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp);

      await tester.tap(find.byKey(Keys.pomodoroButton));
      await tester.pump();
      expect(find.text('25:00'), findsOneWidget);


      await tester.tap(find.byKey(Keys.shortBreakButton));
      await tester.pump();

      expect(find.text('05:00'), findsOneWidget);

      await tester.tap(find.byKey(Keys.longBreakButton));
      await tester.pump();

      expect(find.text('15:00'), findsOneWidget);
    });
  });
}
