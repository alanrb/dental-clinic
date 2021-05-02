import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/user_model.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase implements UseCase<UserModel, RegisterParam> {
  final UserRepository _repo;

  RegisterUseCase(this._repo);

  @override
  Future<Either<Failure, UserModel>> call(RegisterParam params) {
    return _repo.signUp(params.email, params.password, params.fullName);
  }
}

class RegisterParam extends Equatable {
  RegisterParam(
      {required this.email, required this.password, required this.fullName});

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
