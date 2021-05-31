import 'package:dental_clinic/features/domain/model/user_type.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final UserRole role;
  final String? displayName;
  final String? email;
  final String? phoneNumber;

  UserModel({required this.userId, required this.role, required this.displayName, required this.email, required this.phoneNumber});

  @override
  List<Object?> get props => [userId, role, displayName, email, phoneNumber];
}
