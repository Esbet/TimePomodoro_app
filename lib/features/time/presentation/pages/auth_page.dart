import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/menu/menu_bottom_page.dart';
import 'package:timepomodoro_app/core/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/components/custom_text_register_input.dart';
import '../../../../core/components/primary_button.dart';
import '../../../../core/routes/resource_icons.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/widgets/simple_loading.dart';
import '../../../../injection_container.dart';
import '../bloc/time_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const routeName = "/auth";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final timeBloc = getIt<TimeBloc>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.h),
          child: BlocProvider.value(
              value: timeBloc,
              child:
                  BlocConsumer<TimeBloc, TimeState>(listener: (context, state) {
                if (state is LoadingPomodoroState) {
                  setState(() {
                    _isLoading = state.isLoading;
                  });
                }

                if (state is InsertUserState) {
                  if (state.isSaved) {
                      Navigator.pushReplacementNamed(context, MenuBottomPage.routeName);
                  }
                }
              }, builder: (context, state) {
                return Stack(children: [
                  _principalBody(context),
                  Visibility(
                    visible: _isLoading,
                    child: SimpleLoading(color: Colors.white.withOpacity(0.4)),
                  )
                ]);
              })),
        ),
      ),
    );
  }

  Column _principalBody(BuildContext context) {
     AppLocalizations l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        SvgPicture.asset(
          // ignore: deprecated_member_use
          color: whiteColor,
          tomatoSVG,
          width: 30.w,
        ),
        SizedBox(
          height: 4.h,
        ),
        StreamBuilder(
            stream: timeBloc.nameStream,
            builder: (context, snapshot) {
              return CustomTextRegisterInput(
                placeholder: l10n.user,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  timeBloc.setName(text,l10n);
                },
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
              );
            }),
        SizedBox(
          height: 2.h,
        ),
        StreamBuilder(
            stream: timeBloc.emailStream,
            builder: (context, snapshot) {
              return CustomTextRegisterInput(
                placeholder: l10n.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  timeBloc.setEmail(text, l10n);
                },
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
              );
            }),
        SizedBox(
          height: 5.h,
        ),
        StreamBuilder(
            stream: timeBloc.validateAuthForm,
            builder: (context, snapshot) {
              return PrimaryButton(
                onPressed: snapshot.hasData
                    ? () {
                        timeBloc.add(const InsertUserEvent());
                      }
                    : null,
                height: 6.h,
                child: Text(
                  l10n.register,
                  style: textWhiteStyleButton,
                ),
              );
            }),
      ],
    );
  }
}
