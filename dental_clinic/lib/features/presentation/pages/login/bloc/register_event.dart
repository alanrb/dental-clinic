part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class FullNameChanged extends RegisterEvent {
  final String fullName;

  FullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];

  @override
  String toString() => 'FullNameChanged { fullName: $fullName }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String fullName;

  Submitted(
      {required this.email, required this.password, required this.fullName});

  @override
  List<Object?> get props => [email, password, fullName];

  @override
  String toString() =>
      'Submitted { email: $email, password: $password, fullName: $fullName }';
}
