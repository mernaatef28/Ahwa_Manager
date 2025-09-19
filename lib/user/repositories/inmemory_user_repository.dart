import 'package:smart_ahwa_app/user/repositories/user_i_repository.dart';

import '../models/user.dart';

class InMemoryUserRepository implements UserRepository {
  final _users = <int, User>{};

  @override
  Future<void> add(User user) async => _users[user.id] = user;

  @override
  Future<User?> byId(int id) async => _users[id];

  @override
  Future<List<User>> byRole(UserRole role) async =>
      _users.values.where((u) => u.role == role).toList();

  @override
  Future<void> remove(int id) async => _users.remove(id);
}