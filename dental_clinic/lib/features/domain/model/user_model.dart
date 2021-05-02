import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final int role;
  final String? displayName;
  final String? email;
  final String? phoneNumber;

  UserModel({required this.userId, required this.role, required this.displayName, required this.email, required this.phoneNumber});

  @override
  List<Object?> get props => [userId, displayName, email, phoneNumber];
}
