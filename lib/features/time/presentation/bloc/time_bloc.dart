import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timepomodoro_app/core/extensions/string_extension.dart';
import 'package:timepomodoro_app/core/usecases/usecases.dart';
import 'package:timepomodoro_app/features/time/domain/entities/user_entity.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_pomodoro_today_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_total_pomodoros_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/has_user_data_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_breaks_time_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_pomodoro_time_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_user_usecase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/usecases/get_total_breaks_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  //define usecases
  final GetPomodoroTodayUseCase getPomodoroTodayUseCase;
  final InsertPomodoroTimeUseCase insertPomodoroTimeUseCase;
  final GetTotalPomodorosUseCase getTotalPomodorosUseCase;
  final InsertBreaksTimeUseCase insertBreaksTimeUseCase;
  final GetTotalBreaksUseCase getTotalBreaksUseCase;
  final GetUserUseCase getUserUseCase;
  final InsertUserUseCase insertUserUseCase;
  final HasUserDataUseCase hasUserDataUseCase;

  //define controllers
  final _emailController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();

  //define Streams
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get nameStream => _nameController.stream;

  TimeBloc(
      {required this.getPomodoroTodayUseCase,
      required this.insertPomodoroTimeUseCase,
      required this.getTotalPomodorosUseCase,
      required this.insertBreaksTimeUseCase,
      required this.getTotalBreaksUseCase,
      required this.getUserUseCase,
      required this.insertUserUseCase,
      required this.hasUserDataUseCase})
      : super(const TimeState()) {
    on<GetPomodoroTodayEvent>((event, emit) async {
      emit(await _getPomodoroTimeToday(event: event, emit: emit));
    });

    on<InsertPomodoroTimeEvent>((event, emit) async {
      emit(await _insertPomodoroTime(event: event, emit: emit));
    });

    on<GetTotalPomodorosEvent>((event, emit) async {
      emit(await _getTotalPomodoros(event: event, emit: emit));
    });

    on<InsertBreakTimeEvent>((event, emit) async {
      emit(await _insertBreaksTime(event: event, emit: emit));
    });

    on<GetTotalBreaksEvent>((event, emit) async {
      emit(await _getTotalBreaks(event: event, emit: emit));
    });

    on<GetUserEvent>((event, emit) async {
      emit(await _getUser(event: event, emit: emit));
    });

    on<InsertUserEvent>((event, emit) async {
      emit(await _insertUser(event: event, emit: emit));
    });
  }

  Future<TimeState> _getPomodoroTimeToday({
    required GetPomodoroTodayEvent event,
    required Emitter<TimeState> emit,
  }) async {
    emit(const LoadingPomodoroState(isLoading: true));
    final result = await getPomodoroTodayUseCase(
        ParamsUseCaseGetPomodoroToday(date: event.date));
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      emit(const LoadingPomodoroState(isLoading: false));
      return const GetPomodoroTodayState(time: 0);
    }, (resp) {
      emit(const LoadingPomodoroState(isLoading: false));
      return GetPomodoroTodayState(time: resp.result);
    });
  }

  Future<TimeState> _insertPomodoroTime({
    required InsertPomodoroTimeEvent event,
    required Emitter<TimeState> emit,
  }) async {
     emit(const LoadingPomodoroState(isLoading: true));
    final result = await insertPomodoroTimeUseCase(
        ParamsUseCaseInsertPomodoroTime(
            date: event.date, minutes: event.minutes));
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      emit(const LoadingPomodoroState(isLoading: false));
      return const InsertPomodoroTimeState(isSaved: false);
    }, (resp) {
      emit(const LoadingPomodoroState(isLoading: false));
      return InsertPomodoroTimeState(isSaved: resp.result);
    });
  }

  Future<TimeState> _getUser({
    required GetUserEvent event,
    required Emitter<TimeState> emit,
  }) async {
    final result = await getUserUseCase(NoParams());
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      return const GetUserState(user: UserEntity.empty());
    }, (resp) {
      return GetUserState(user: resp.result);
    });
  }

  Future<TimeState> _getTotalPomodoros({
    required GetTotalPomodorosEvent event,
    required Emitter<TimeState> emit,
  }) async {
    emit(const LoadingPomodoroState(isLoading: true));
    final result = await getTotalPomodorosUseCase(NoParams());
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      emit(const LoadingPomodoroState(isLoading: false));
      return const GetTotalPomodorosState(time: 0);
    }, (resp) {
      emit(const LoadingPomodoroState(isLoading: false));
      return GetTotalPomodorosState(time: resp.result);
    });
  }

  Future<TimeState> _insertBreaksTime({
    required InsertBreakTimeEvent event,
    required Emitter<TimeState> emit,
  }) async {
    // emit(const LoadiState(isLoading: true));
    final result = await insertBreaksTimeUseCase(ParamsUseCaseInsertBreaksTime(
        date: event.date, minutes: event.minutes));
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      //  emit(const LoadingStep2State(isLoading:false));
      return const InsertBreakTimeState(isSaved: false);
    }, (resp) {
      // emit(const LoadingStep2State(isLoading: false));
      return InsertBreakTimeState(isSaved: resp.result);
    });
  }

  Future<TimeState> _getTotalBreaks({
    required GetTotalBreaksEvent event,
    required Emitter<TimeState> emit,
  }) async {
    emit(const LoadingPomodoroState(isLoading: true));
    final result = await getTotalBreaksUseCase(NoParams());
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      emit(const LoadingPomodoroState(isLoading: false));
      return const GetTotalBreaksState(time: 0);
    }, (resp) {
      emit(const LoadingPomodoroState(isLoading: false));
      return GetTotalBreaksState(time: resp.result);
    });
  }

  Future<TimeState> _insertUser({
    required InsertUserEvent event,
    required Emitter<TimeState> emit,
  }) async {
    // emit(const LoadiState(isLoading: true));
    final result = await insertUserUseCase(ParamsUseCaseInsertUser(
        email: _emailController.value, name: _nameController.value));
    return result.fold((failure) {
      emit(FailedPomodoroTimeState(
        message: failure.props.isNotEmpty ? failure.props.first.toString() : '',
      ));
      //  emit(const LoadingStep2State(isLoading:false));
      return const InsertUserState(isSaved: false);
    }, (resp) {
      // emit(const LoadingStep2State(isLoading: false));
      return InsertUserState(isSaved: resp.result);
    });
  }

  Future<bool> isUserLogin() async {
    final result = await hasUserDataUseCase(NoParams());

    return result.fold((failure) {
      return false;
    }, (resp) {
      return resp.result;
    });
  }

  void setEmail(String userEmail, AppLocalizations l10n) async {
    if (userEmail.isEmpty) {
      _emailController.sink.addError(l10n.requiredField);
    } else if (!userEmail.validateEmail) {
      _emailController.sink.addError(l10n.loginEmailError);
    } else {
      _emailController.sink.add(userEmail);
    }
  }

  void setName(String field, AppLocalizations l10n) async {
    if (field.isEmpty) {
      _nameController.sink.addError(l10n.requiredField);
    } else {
      _nameController.sink.add(field);
    }
  }

  //check login validation form
  Stream<bool> get validateAuthForm => Rx.combineLatest2(
        emailStream,
        nameStream,
        (a, b) => true,
      );
}
