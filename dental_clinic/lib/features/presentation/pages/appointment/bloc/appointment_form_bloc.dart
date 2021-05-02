import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/domain/usecases/create_appointment_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_doctor_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/get_issue_case_usecase.dart';
import 'package:equatable/equatable.dart';

part 'appointment_form_event.dart';

part 'appointment_form_state.dart';

class AppointmentFormBloc
    extends Bloc<AppointmentFormEvent, AppointmentFormState> {
  final GetIssueCaseUseCase getIssueCaseUseCase;
  final GetDoctorUseCase getDoctorUseCase;
  final AddAppointmentUseCase addUseCase;

  StreamSubscription<Either<Failure, List<IssueCaseModel>>>?
      _casesStreamSubscription;
  StreamSubscription<Either<Failure, List<DoctorModel>>>?
      _doctorStreamSubscription;

  AppointmentFormBloc(
      this.getIssueCaseUseCase, this.getDoctorUseCase, this.addUseCase)
      : super(Initial());

  @override
  Stream<AppointmentFormState> mapEventToState(
    AppointmentFormEvent event,
  ) async* {
    if (event is LoadCases) {
      _casesStreamSubscription?.cancel();
      _casesStreamSubscription =
          getIssueCaseUseCase(NoParams()).listen((event) {
        add(CaseReceived(event));
      });
    }

    if (event is CaseReceived) {
      yield event.model.fold(
          (failure) => CaseLoaded([], _mapFailureToMessage(failure)),
          (cases) => CaseLoaded(cases, null));
    }

    if (event is CaseSelected) {
      yield DateTimeLoaded();
    }

    if (event is DateTimeSelected) {
      _doctorStreamSubscription?.cancel();
      _doctorStreamSubscription = getDoctorUseCase(NoParams()).listen((event) {
        add(DoctorReceived(event));
      });
    }

    if (event is DoctorReceived) {
      yield event.model.fold(
          (failure) => DoctorLoaded([], _mapFailureToMessage(failure)),
          (doctors) => DoctorLoaded(doctors, null));
    }

    if (event is DoctorSelected) {
      yield AppointmentForm();
    }

    if (event is SubmitAppointment) {
      yield Loading();
      final failureOrResult = await addUseCase(AppointmentModel(
          userId: event.user,
          issueId: event.issueId,
          issueTitle: event.issueTitle,
          time: event.time,
          doctorId: event.doctor.id,
          note: event.note,
          branch: 'V4UGfpIkuruxvZwKHX1X'));
      yield failureOrResult.fold(
          (failure) =>
              AppointmentFormError(message: _mapFailureToMessage(failure)),
          (appointmentId) => AppointmentAdded(appointmentId));
    }
  }

  @override
  Future<void> close() async {
    await _casesStreamSubscription?.cancel();
    await _doctorStreamSubscription?.cancel();
    return super.close();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'No Internet connection';
      default:
        return 'Unexpected error';
    }
  }
}
