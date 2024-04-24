import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/components/custom_text_register_input.dart';
import 'package:timepomodoro_app/core/components/primary_button.dart';
import 'package:timepomodoro_app/core/routes/page_generator.dart';
import 'package:timepomodoro_app/core/theme/app_theme.dart';
import 'package:timepomodoro_app/core/utils/keys.dart';
import 'package:timepomodoro_app/features/time/presentation/pages/auth_page.dart';
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
            initialRoute: AuthPage.routeName,
            onGenerateRoute: PageClassGenerator.getNamedScreen,
          );
        },
      );
    });

    testWidgets('AuthPage widget validation button when input has data', (WidgetTester tester) async {
      
      await tester.pumpWidget(testApp);

      
      Finder nameField = find.byKey(Keys.inputName);
      Finder emailField = find.byKey(Keys.inputEmail);
      Finder registerButton = find.byKey(Keys.registerButton);
      expect(tester.widget<PrimaryButton>(registerButton).onPressed, isNull);
      await tester.enterText(nameField, 'Estiven');
      await tester.enterText(emailField, 'ebetancur@gmail.com');
      expect(tester.widget<PrimaryButton>(registerButton).onPressed, isNull);
      await tester.enterText(emailField, 'ebetancur@gmail.com');
      expect(tester.widget<PrimaryButton>(registerButton).onPressed, isNotNull);
    });

    testWidgets(
        'AuthPage widget navigates to MenuBottomPage when user is saved',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      Finder nameField = find.byKey(Keys.inputName);
      Finder emailField = find.byKey(Keys.inputEmail);
      Finder registerButton = find.byKey(Keys.registerButton);
      await tester.enterText(nameField, 'Estiven');
      await tester.enterText(emailField, 'ebetancur@gmail.com');
      expect(tester.widget<PrimaryButton>(registerButton).onPressed, isNull);
      await tester.enterText(emailField, 'ebetancur@gmail.com');
      expect(tester.widget<PrimaryButton>(registerButton).onPressed, isNotNull);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();
    });

    testWidgets('Error message is displayed for invalid email',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      Finder emailField = find.byKey(Keys.inputEmail);
      await tester.enterText(emailField, 'correo-invalido');
      await tester.pump();
      CustomTextRegisterInput emailInputWidget = tester.widget(emailField);
      expect(emailInputWidget.errorText, 'The email is incorrect');
    });
  });
}
