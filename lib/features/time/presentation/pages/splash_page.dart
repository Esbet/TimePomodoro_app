import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/menu/menu_bottom_page.dart';
import 'package:timepomodoro_app/core/routes/resource_icons.dart';
import 'package:timepomodoro_app/features/time/presentation/bloc/time_bloc.dart';
import 'package:timepomodoro_app/features/time/presentation/pages/auth_page.dart';

import '../../../../core/theme/colors.dart';
import '../../../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = "/";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimeBloc timeBloc = getIt<TimeBloc>();
  @override
  void initState() {
    processScreen();
    super.initState();
  }

  Future<void> processScreen() async {
    bool isUserLogin = await timeBloc.isUserLogin();
    await Future.delayed(const Duration(seconds: 3));
    navigation(isUserLogin);
  }

  void navigation(bool isUserLogin) {
    if (isUserLogin) {
      Navigator.pushReplacementNamed(context, MenuBottomPage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, AuthPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(color: whiteColor, child: _mainScreen())),
    );
  }

  Widget _mainScreen() {
    return Stack(
      children: [
        _titleScreen(),
      ],
    );
  }

  Widget _titleScreen() {
    return Align(
      alignment: Alignment.center,
      child: Image(
        image: const AssetImage(quindImage),
        fit: BoxFit.cover,
        height: 15.h,
      ),
    );
  }
}
