import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/usecases/get_user_appointment_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/get_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'recent_appointment_event.dart';

part 'recent_appointment_state.dart';

class RecentAppointmentBloc
    extends Bloc<RecentAppointmentEvent, RecentAppointmentState> {
  final GetUserUseCase getUserUseCase;
  final GetUserAppointmentUseCase getUserAppointmentUseCase;

  StreamSubscription<Either<Failure, List<AppointmentModel>>>?
      _appointmentStreamSubscription;

  RecentAppointmentBloc(this.getUserUseCase, this.getUserAppointmentUseCase)
      : super(Initial());

  @override
  Stream<RecentAppointmentState> mapEventToState(
    RecentAppointmentEvent event,
  ) async* {
    if (event is LoadRecent) {
      final failureOrResult = await getUserUseCase(NoParams());
      failureOrResult.fold((failure) => _mapUserToFailure(failure),
          (user) => _mapUserToAppointment(user.userId));
    }

    if (event is Received) {
      yield event.model.fold(
          (failure) => AppointmentLoaded([], _mapFailureToMessage(failure)),
          (doctors) => AppointmentLoaded(doctors, null));
    }
  }

  _mapUserToFailure(Failure failure) async* {
    yield AppointmentLoaded([], _mapFailureToMessage(failure));
  }

  _mapUserToAppointment(String userId) {
    _appointmentStreamSubscription?.cancel();
    _appointmentStreamSubscription =
        getUserAppointmentUseCase(userId).listen((event) {
      add(Received(event));
    });
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
