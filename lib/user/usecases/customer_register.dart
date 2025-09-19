import '../models/user.dart';
import '../repositories/user_i_repository.dart';

class RegisterCustomer {
  final UserRepository repo;
  RegisterCustomer(this.repo);

  Future<void> call({required int id, required String name}) {
    final user = User(id, name, UserRole.customer);
    return repo.add(user);
  }
}
