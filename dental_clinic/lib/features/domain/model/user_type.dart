enum UserRole { admin, user, doctor, unknown }

extension UserRoleId on UserRole {
  int toId() {
    switch (this) {
      case UserRole.admin:
        return 1;
      case UserRole.user:
        return 2;
      case UserRole.doctor:
        return 3;
      default:
        return -1;
    }
  }

  static UserRole parse(int id) {
    switch (id) {
      case 1:
        return UserRole.admin;
      case 2:
        return UserRole.user;
      case 3:
        return UserRole.doctor;
      default:
        return UserRole.unknown;
    }
  }
}