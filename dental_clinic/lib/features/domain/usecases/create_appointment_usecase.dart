import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';

class AddAppointmentUseCase implements UseCase<String, AppointmentModel> {
  final AppointmentRepository repository;

  AddAppointmentUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(AppointmentModel params) async {
    return await repository.create(params);
  }
}

