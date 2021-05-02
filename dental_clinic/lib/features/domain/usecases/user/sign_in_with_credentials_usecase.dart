import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/user_model.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class SignInWithCredentialsUseCase implements UseCase<UserModel, SignInWithCredentialsParam> {

  final UserRepository _repo;

  SignInWithCredentialsUseCase(this._repo);

  @override
  Future<Either<Failure, UserModel>> call(SignInWithCredentialsParam params) {
    return _repo.signInWithCredentials( params.email,  params.password);
  }

}

class SignInWithCredentialsParam extends Equatable {
  SignInWithCredentialsParam({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}