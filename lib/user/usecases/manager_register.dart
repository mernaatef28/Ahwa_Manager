import '../models/user.dart';
import '../repositories/user_i_repository.dart';

class RegisterManager {
  final UserRepository repo;
  RegisterManager(this.repo);

  Future<void> call({required int id, required String name}) {
    final user = User(id, name, UserRole.manager);
    return repo.add(user);
  }
}