import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timepomodoro_app/core/routes/resource_icons.dart';
import 'package:timepomodoro_app/core/theme/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timepomodoro_app/core/theme/fonts.dart';
import 'package:intl/intl.dart';
import 'package:timepomodoro_app/core/utils/contants.dart';
import 'package:timepomodoro_app/features/time/presentation/widgets/option_button.dart';
import '../../../../core/widgets/simple_loading.dart';
import '../../../../injection_container.dart';
import '../bloc/time_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final timeBloc = getIt<TimeBloc>();
  AudioPlayer _player = AudioPlayer();
  bool _isLoading = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer _timer = Timer(const Duration(seconds: 0), () {});
  String _elapsedTime = Constants.pomodoro;
  int _selectedButtonIndex = 0;
  String name = '';

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    timeBloc.add(
      const GetUserEvent(),
    );
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: BlocProvider.value(
                value: timeBloc,
                child: BlocConsumer<TimeBloc, TimeState>(
                    listener: (context, state) {
                  if (state is LoadingPomodoroState) {
                    setState(() {
                      _isLoading = state.isLoading;
                    });
                  }

                  if (state is GetUserState) {
                    name = state.user.name;
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
        ));
  }

  SingleChildScrollView _principalBody(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${l10n.hi}, $name",
                style: textWhiteStyleTitle,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: lightGrayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionButton(
                      index: 0,
                      indexSelected: _selectedButtonIndex,
                      label: l10n.pomodoro,
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 0;
                          _elapsedTime =Constants.pomodoro;
                        });
                      },
                    ),
                    SizedBox(width: 2.w,),
                    OptionButton(
                      index: 1,
                      indexSelected: _selectedButtonIndex,
                      label: l10n.shortBreak,
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 1;
                          _elapsedTime = Constants.shortBreak;
                        });
                      },
                    ),
                    SizedBox(width: 2.w,),
                    OptionButton(
                      index: 2,
                      indexSelected: _selectedButtonIndex,
                      label: l10n.longBreak,
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 2;
                          _elapsedTime =Constants.longBreak;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            _elapsedTime,
            style: textWhiteStyleTimer,
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              _startStopwatch();
            },
            child: Container(
              width: 130,
              height: 130,
              decoration: const ShapeDecoration(
                color: pinkColor,
                shape: CircleBorder(),
              ),
              child: const Icon(
                Icons.play_arrow_outlined,
                color: blackColor,
                size: 40.0,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            _stopwatch.isRunning
                ? l10n.stop
                : (_stopwatch.elapsed.inSeconds == 0
                    ? l10n.start
                    : l10n.resume),
            style: textWhiteStyleTitle,
          )
        ],
      ),
    );
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      final Map<int, Map<String, int>> buttonData = {
        0: {'time': Constants.pomodoroSec, 'totalMinutes':  Constants.pomodoroMin},
        1: {'time': Constants.shortBreakSec, 'totalMinutes':  Constants.shortBreakMin},
        2: {'time':Constants.longBreakSec, 'totalMinutes': Constants.longBreakMin},
      };

      setState(() {
        final Map<String, int> data =
            buttonData[_selectedButtonIndex] ?? {'time': 0, 'totalMinutes': 0};
        int time = data['time'] ?? 0;
        int totMinutes = data['totalMinutes'] ?? 0;

        if (_stopwatch.elapsed.inSeconds >= time) {
          _stopwatch.stop();
        } else {
          int remainingSeconds = time - _stopwatch.elapsed.inSeconds;
          int minutes = remainingSeconds ~/ 60;
          int seconds = remainingSeconds % 60;
          _elapsedTime =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
          if (_elapsedTime == "00:01") {
            _player.play(AssetSource(alarmMp3));
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('dd/MM/yyyy').format(now);
            if (_selectedButtonIndex == 0) {
              timeBloc.add(
                InsertPomodoroTimeEvent(
                    date: formattedDate, minutes: totMinutes),
              );
            } else {
              timeBloc.add(
                InsertBreakTimeEvent(date: formattedDate, minutes: totMinutes),
              );
            }
          }
        }
      });
    }
  }
}
