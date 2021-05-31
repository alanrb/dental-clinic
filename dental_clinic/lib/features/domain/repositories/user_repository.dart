import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> signInWithCredentials(String email, String password);
  Future<Either<Failure, UserModel>> signUp(String email, String password, String fullName);
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, UserModel>> getUser();
}
