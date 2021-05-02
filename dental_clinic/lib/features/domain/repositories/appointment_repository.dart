import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';

abstract class AppointmentRepository {
  Stream<Either<Failure, List<IssueCaseModel>>> getCases();
  Stream<Either<Failure, List<DoctorModel>>> getDoctor();
  Stream<Either<Failure, List<AppointmentModel>>> getByUser(String userId);
  Stream<Either<Failure, List<AppointmentModel>>> getUserAppointment();
  Future<Either<Failure, String>> create(AppointmentModel appointment);
  Future<Either<Failure, Unit>> update(AppointmentModel appointment);
  Future<Either<Failure, Unit>> delete(AppointmentModel appointment);
}