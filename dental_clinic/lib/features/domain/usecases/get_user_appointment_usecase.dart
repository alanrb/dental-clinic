import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';

class GetUserAppointmentUseCase implements StreamUseCase<List<AppointmentModel>, String> {

  final AppointmentRepository repository;

  GetUserAppointmentUseCase(this.repository);

  @override
  Stream<Either<Failure, List<AppointmentModel>>> call(String params) {
    return repository.getByUser(params);
  }
}