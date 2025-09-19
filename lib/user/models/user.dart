// domain/entities/user.dart
enum UserRole { customer, manager }

class User {
  final int id;
  final String name;
  final UserRole role;
  User(this.id, this.name, this.role);
}
