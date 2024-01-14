abstract class BaseAuthRepository {
  Future<void> login(String username, String password);
  Future<void> logout();
}