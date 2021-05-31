part of 'appointment_form_bloc.dart';

class AppointmentSummary extends Equatable {
  final IssueCaseModel? issue;
  final String? dateTime;
  final DoctorModel? doctor;

  AppointmentSummary(this.issue, this.dateTime, this.doctor);

  @override
  List<Object?> get props => [issue, dateTime, doctor];
}

abstract class AppointmentFormState extends Equatable {
  const AppointmentFormState();

  AppointmentFormState.initial() : this();
}

class Initial extends AppointmentFormState {

  final String? userId;

  Initial(this.userId);

  @override
  List<Object> get props => [];
}

class CaseLoaded extends AppointmentFormState {
  final List<IssueCaseModel> cases;
  final String? error;

  CaseLoaded(this.cases, this.error);

  @override
  List<Object> get props => [cases];
}

class DateTimeLoaded extends AppointmentFormState {
  @override
  List<Object?> get props => [];
}

class DoctorLoaded extends AppointmentFormState {
  final List<DoctorModel> doctor;
  final String? error;

  DoctorLoaded(this.doctor, this.error);

  @override
  List<Object> get props => [];
}

class AppointmentForm extends AppointmentFormState {

  @override
  List<Object> get props => [];
}

class Loading extends AppointmentFormState {
  @override
  List<Object> get props => [];
}

class AppointmentAdded extends AppointmentFormState {
  final String appointmentId;

  AppointmentAdded(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class AppointmentFormError extends AppointmentFormState {
  final String message;

  AppointmentFormError({required this.message});

  @override
  List<Object> get props => [message];
}
