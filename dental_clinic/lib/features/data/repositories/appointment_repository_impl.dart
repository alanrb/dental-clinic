import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {

  @override
  Stream<Either<Failure, List<IssueCaseModel>>> getCases() {
    // TODO: implement getCases
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<DoctorModel>>> getDoctor() {
    // TODO: implement getDoctor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> create(AppointmentModel appointment) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> delete(AppointmentModel appointment) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> update(AppointmentModel appointment) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<AppointmentModel>>> getUserAppointment() {
    // TODO: implement getUserAppointment
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<AppointmentModel>>> getByUser(String userId) {
    // TODO: implement getByUser
    throw UnimplementedError();
  }

}