part of 'recent_appointment_bloc.dart';

abstract class RecentAppointmentState extends Equatable {
  const RecentAppointmentState();
}

class Initial extends RecentAppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoaded extends RecentAppointmentState {

  final List<AppointmentModel> cases;
  final String? error;

  AppointmentLoaded(this.cases, this.error);

  @override
  List<Object> get props => [cases];
}