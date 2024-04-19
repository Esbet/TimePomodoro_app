part of 'time_bloc.dart';

class TimeState extends Equatable {
  const TimeState();
  TimeState copyWith() => const TimeState();
  @override
  List<Object?> get props => [];
}

class InsertPomodoroTimeState extends TimeState {
  final bool isSaved;
  const InsertPomodoroTimeState({required this.isSaved});
  @override
  List<Object?> get props => [isSaved];
}

class GetPomodoroTodayState extends TimeState {
  final int time;
  const GetPomodoroTodayState({
    required this.time,
  });
}

class GetTotalPomodorosState extends TimeState {
  final int time;
  const GetTotalPomodorosState({
    required this.time,
  });
}

class FailedPomodoroTimeState extends TimeState {
  final String message;
  const FailedPomodoroTimeState({required this.message});
}

class LoadingPomodoroState extends  TimeState {
  final bool isLoading;
  const LoadingPomodoroState({required this.isLoading});
  @override
  List<Object?> get props => [isLoading];
}

class InsertBreakTimeState extends TimeState {
  final bool isSaved;
  const InsertBreakTimeState({required this.isSaved});
  @override
  List<Object?> get props => [isSaved];
}

class GetTotalBreaksState extends TimeState {
  final int time;
  const GetTotalBreaksState({
    required this.time,
  });
}

class GetUserState extends TimeState {
  final UserEntity user;
  const GetUserState({required this.user});
}

class InsertUserState extends TimeState {
  final bool isSaved;
  const InsertUserState({required this.isSaved});
  @override
  List<Object?> get props => [isSaved];
}
