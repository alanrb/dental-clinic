import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';

class GetDoctorUseCase implements StreamUseCase<List<DoctorModel>, NoParams> {
  final AppointmentRepository repository;

  GetDoctorUseCase(this.repository);

  @override
  Stream<Either<Failure, List<DoctorModel>>> call(NoParams params) {
    return repository.getDoctor();
  }

}