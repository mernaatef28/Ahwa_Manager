import '../models/user.dart';
import '../repositories/user_i_repository.dart';

class ManagerService {
  final UserRepository users;
  ManagerService(this.users);

  Future<List<User>> listManagers() => users.byRole(UserRole.manager);
}