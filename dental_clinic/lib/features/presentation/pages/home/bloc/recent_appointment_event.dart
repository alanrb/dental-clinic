part of 'recent_appointment_bloc.dart';

abstract class RecentAppointmentEvent extends Equatable {
}

class LoadRecent extends RecentAppointmentEvent {

  final String userId;

  LoadRecent(this.userId);
  @override
  List<Object?> get props => [];
}

class Received extends RecentAppointmentEvent {
  final Either<Failure, List<AppointmentModel>> model;

  Received(this.model);

  @override
  List<Object?> get props => [model];
}