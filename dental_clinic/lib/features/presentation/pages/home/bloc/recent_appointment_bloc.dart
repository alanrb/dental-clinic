import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/usecases/get_user_appointment_usecase.dart';
import 'package:equatable/equatable.dart';

part 'recent_appointment_event.dart';
part 'recent_appointment_state.dart';

class RecentAppointmentBloc extends Bloc<RecentAppointmentEvent, RecentAppointmentState> {

  final GetUserAppointmentUseCase getUserAppointmentUseCase;

  StreamSubscription<Either<Failure, List<AppointmentModel>>>?
  _appointmentStreamSubscription;

  RecentAppointmentBloc(this.getUserAppointmentUseCase) : super(Initial());

  @override
  Stream<RecentAppointmentState> mapEventToState(
    RecentAppointmentEvent event,
  ) async* {
    if (event is LoadRecent) {
      _appointmentStreamSubscription?.cancel();
      _appointmentStreamSubscription = getUserAppointmentUseCase(event.userId).listen((event) {
        add(Received(event));
      });
    }

    if(event is Received) {
      yield event.model.fold(
              (failure) => AppointmentLoaded([], _mapFailureToMessage(failure)),
              (doctors) => AppointmentLoaded(doctors, null));
    }
  }

  @override
  Future<void> close() async {
    await _appointmentStreamSubscription?.cancel();
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
