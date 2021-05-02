import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';

class SignOutUseCase implements UseCase<bool, NoParams> {

  final UserRepository userRepository;

  SignOutUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return userRepository.signOut();
  }

}