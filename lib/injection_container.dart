import 'package:get_it/get_it.dart';

import 'application/repositories/repositories.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton(() => AuthRepository());
}

