import 'package:timepomodoro_app/features/time/data/models/user_model.dart';

abstract class LocalDatasource {
  ///Method that allows you to get total pomodoros dor date
  Future<int> getTotalMinutesForDate(String date);

  ///Method that allows you to insert minutes
  Future<bool> saveTotalMinutesForDate(String date, int minutes);

  ///Method that allows you to get total pomodoros
  Future<int> getTotalPomodoros();

  ///Method that allows you to insert total breaks
  Future<bool> saveTotalBreaksForDate(String date, int minutes);

  ///Method that allows you to get total breaks
  Future<int> getTotalBreaks();

  ///Method that allows you to save user
  Future<bool> saveUser(String name, String email);

  ///Method that allows you to get User
  Future<UserModel> getUser();

  ///Method that allows you to validate if user exists
  Future<bool> hasUserData();
}
