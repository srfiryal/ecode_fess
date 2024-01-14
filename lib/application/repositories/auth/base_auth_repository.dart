import '../../../data/models/user/user_model.dart';

abstract class BaseAuthRepository {
  Future<void> login(String username, String password);
  Future<void> logout();
  Future<void> getUserData();
}