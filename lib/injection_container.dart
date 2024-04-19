import 'package:get_it/get_it.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_pomodoro_today_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_total_pomodoros_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/has_user_data_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_breaks_time_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_pomodoro_time_usecase.dart';
import 'package:timepomodoro_app/features/time/presentation/bloc/time_bloc.dart';

import 'features/time/data/datasources/local_datasource.dart';
import 'features/time/data/datasources/local_datasource_impl.dart';
import 'features/time/data/repositories/time_repository_impl.dart';
import 'features/time/domain/repositories/time_repository.dart';
import 'features/time/domain/usecases/get_total_breaks_usecase.dart';
import 'features/time/domain/usecases/get_user_usecase.dart';
import 'features/time/domain/usecases/insert_user_usecase.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies() async {
  //Bloc
  getIt.registerFactory(() => TimeBloc(
      getPomodoroTodayUseCase: getIt(),
      insertPomodoroTimeUseCase: getIt(),
      getTotalPomodorosUseCase: getIt(),
      insertBreaksTimeUseCase: getIt(), 
      getTotalBreaksUseCase: getIt(),
      getUserUseCase: getIt(), 
      insertUserUseCase: getIt(),
      hasUserDataUseCase: getIt()));

  //UseCase
  getIt.registerLazySingleton(
      () => GetPomodoroTodayUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => InsertPomodoroTimeUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetTotalPomodorosUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => InsertBreaksTimeUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetTotalBreaksUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetUserUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => InsertUserUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => HasUserDataUseCase(repository: getIt()));
  //Repository
  getIt.registerLazySingleton<TimeRepository>(
    () => TimeRepositoryImp(
      localDatabaseRepository: getIt(),
    ),
  );

  //Datasource
  getIt.registerLazySingleton<LocalDatasource>(() => LocalDatasourceImpl());
}
