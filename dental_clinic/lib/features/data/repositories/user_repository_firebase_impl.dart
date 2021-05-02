import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/network/network_info.dart';
import 'package:dental_clinic/features/domain/model/user_model.dart';
import 'package:dental_clinic/features/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryFirebaseImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NetworkInfo networkInfo;

  UserRepositoryFirebaseImpl(this.networkInfo);

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return left(ServerFailure());
    }
    return right(UserModel(
        userId: currentUser.uid,
        role: 1,
        displayName: currentUser.displayName,
        email: currentUser.email,
        phoneNumber: currentUser.phoneNumber));
  }

  @override
  Future<Either<Failure, UserModel>> signInWithCredentials(
      String email, String password) async {
    var firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (firebaseUser.user == null) {
      return left(ServerFailure());
    }
    return right(UserModel(
        userId: firebaseUser.user!.uid,
        role: 1,
        displayName: firebaseUser.user!.displayName,
        email: firebaseUser.user!.email,
        phoneNumber: firebaseUser.user!.phoneNumber));
  }

  @override
  Future<Either<Failure, UserModel>> signUp(
      String email, String password, String fullName) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateProfile(displayName: fullName);

      return right(UserModel(
          userId: credential.user!.uid,
          role: 1,
          displayName: credential.user!.displayName,
          email: credential.user!.email,
          phoneNumber: credential.user!.phoneNumber));
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    await _firebaseAuth.signOut();
    return right(true);
  }
}
