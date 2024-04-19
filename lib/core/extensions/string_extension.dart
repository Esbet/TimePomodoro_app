
const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

extension StringX on String {

  bool get validateEmail => RegExp(emailRegex).hasMatch(this);
}
