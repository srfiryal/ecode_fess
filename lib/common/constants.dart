import 'package:logger/logger.dart';

class Constants {
  static const baseUrl = 'https://dummyjson.com';
  static final logger = Logger();

  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String delete = 'delete';

  static const String prefToken = 'token';

  static const String snackBarSuccess = 'success';
  static const String snackBarWarning = 'warning';
  static const String snackBarDanger = 'danger';
}