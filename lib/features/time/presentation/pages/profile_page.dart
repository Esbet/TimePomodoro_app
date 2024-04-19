import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/routes/resource_icons.dart';
import 'package:timepomodoro_app/features/time/domain/entities/user_entity.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/widgets/simple_loading.dart';
import '../../../../injection_container.dart';
import '../bloc/time_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = "/";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  final timeBloc = getIt<TimeBloc>();
  int totMinutesToday = 0;
  int totPomodorosToday = 0;

  UserEntity user = const UserEntity.empty();

  int totMinutes = 0;
  int totPomodoros = 0;

  int totBreaks = 0;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    timeBloc.add(
      GetPomodoroTodayEvent(date: formattedDate),
    );

    timeBloc.add(
      const GetTotalPomodorosEvent(),
    );

    timeBloc.add(
      const GetTotalBreaksEvent(),
    );

    timeBloc.add(
      const GetUserEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.h),
          child: SingleChildScrollView(
            child: BlocProvider.value(
                value: timeBloc,
                child: BlocConsumer<TimeBloc, TimeState>(
                    listener: (context, state) {
                  if (state is LoadingPomodoroState) {
                    setState(() {
                      _isLoading = state.isLoading;
                    });
                  }

                  if (state is GetPomodoroTodayState) {
                    setState(() {
                      totMinutesToday = state.time;
                      totPomodorosToday = totMinutesToday ~/ 25;
                    });
                  }

                  if (state is GetTotalPomodorosState) {
                    setState(() {
                      totMinutes = state.time;
                      totPomodoros = totMinutes ~/ 25;
                    });
                  }

                  if (state is GetTotalBreaksState) {
                    setState(() {
                      totBreaks = state.time;
                    });
                  }

                  if (state is GetUserState) {
                    user = state.user;
                  }
                }, builder: (context, state) {
                  return Stack(children: [
                    _principalBody(context),
                    Visibility(
                      visible: _isLoading,
                      child:
                          SimpleLoading(color: Colors.white.withOpacity(0.4)),
                    )
                  ]);
                })),
          ),
        ),
      ),
    );
  }

  Column _principalBody(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.profile,
              style: textWhiteStyleTitle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              profileSVG,
              height: 20.h,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(user.name != "" ? user.name.substring(0, 1) : "",
                      style: textBlackStyleTitle),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.email,
              style: textWhiteStyleTitle,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: pinkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Column(
                          children: [
                            Text(
                              l10n.todayFocus,
                              style: textBlackStyle,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text("$totPomodorosToday",
                                style: textBlackStyleTitle),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "$totMinutesToday ${l10n.minutes}",
                              style: textBlackStyleSmall,
                            ),
                          ],
                        )))
              ],
            ),
            Column(
              children: [
                Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Column(
                          children: [
                            Text(
                              l10n.allFocus,
                              style: textBlackStyle,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text("$totPomodoros", style: textBlackStyleTitle),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "$totMinutes ${l10n.minutes}",
                              style: textBlackStyleSmall,
                            ),
                          ],
                        )))
              ],
            )
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    children: [
                      Text(
                        l10n.totalBreaks,
                        style: textBlackStyle,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text("$totBreaks", style: textBlackStyleTitle),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        l10n.takingBreaks,
                        style: textBlackStyleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
