import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';

class GetIssueCaseUseCase implements StreamUseCase<List<IssueCaseModel>, NoParams> {
  final AppointmentRepository repository;

  GetIssueCaseUseCase(this.repository);

  @override
  Stream<Either<Failure, List<IssueCaseModel>>> call(NoParams params) {
    return repository.getCases();
  }

}
