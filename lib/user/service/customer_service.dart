import '../models/user.dart';
import '../repositories/user_i_repository.dart';

class CustomerService {
  final UserRepository users;
  CustomerService(this.users);

  Future<List<User>> listCustomers() => users.byRole(UserRole.customer);
}
