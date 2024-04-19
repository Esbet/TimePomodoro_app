part of 'time_bloc.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();
}

class GetPomodoroTodayEvent extends TimeEvent {
  final String date;
  const GetPomodoroTodayEvent({required this.date});
  @override
  List<Object?> get props => [];
}

class InsertPomodoroTimeEvent extends TimeEvent {
  final String date;
  final int minutes;
  const InsertPomodoroTimeEvent({required this.date, required this.minutes});
  @override
  List<Object?> get props => [];
}

class GetTotalPomodorosEvent extends TimeEvent {
  const GetTotalPomodorosEvent();
  @override
  List<Object?> get props => [];
}

class InsertBreakTimeEvent extends TimeEvent {
  final String date;
  final int minutes;
  const InsertBreakTimeEvent({required this.date, required this.minutes});
  @override
  List<Object?> get props => [];
}

class GetTotalBreaksEvent extends TimeEvent {
  const GetTotalBreaksEvent();
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends TimeEvent {
  const GetUserEvent();
  @override
  List<Object?> get props => [];
}

class InsertUserEvent extends TimeEvent {
  const InsertUserEvent();
  @override
  List<Object?> get props => [];
}
