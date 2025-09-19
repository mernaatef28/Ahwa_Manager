import '../models/user.dart';

abstract class UserRepository {
  Future<void> add(User user);
  Future<User?> byId(int id);
  Future<List<User>> byRole(UserRole role);
  Future<void> remove(int id);
}