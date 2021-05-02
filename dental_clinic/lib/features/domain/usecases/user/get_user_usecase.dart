import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/user_model.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';

class GetUserUseCase implements UseCase<UserModel, NoParams> {
  final UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) {
    return userRepository.getUser();
  }

}