part of 'appointment_form_bloc.dart';

abstract class AppointmentFormEvent extends Equatable {}

class LoadUser extends AppointmentFormEvent {
  @override
  List<Object?> get props => [];
}

class LoadCases extends AppointmentFormEvent {
  @override
  List<Object?> get props => [];
}

class CaseReceived extends AppointmentFormEvent {
  final Either<Failure, List<IssueCaseModel>> model;

  CaseReceived(this.model);

  @override
  List<Object?> get props => [model];
}

class CaseSelected extends AppointmentFormEvent {
  final IssueCaseModel caseModel;

  CaseSelected(this.caseModel);

  @override
  List<Object?> get props => [caseModel];
}

class DateTimeSelected extends AppointmentFormEvent {
  final DateTime time;

  DateTimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

class DoctorReceived extends AppointmentFormEvent {
  final Either<Failure, List<DoctorModel>> model;

  DoctorReceived(this.model);

  @override
  List<Object?> get props => [model];
}

class DoctorSelected extends AppointmentFormEvent {
  final DoctorModel doctor;

  DoctorSelected(this.doctor);

  @override
  List<Object?> get props => [doctor];
}

class SubmitAppointment extends AppointmentFormEvent {
  final String user;
  final String issueId;
  final String issueTitle;
  final int time;
  final DoctorModel doctor;
  final String? note;

  SubmitAppointment(
      {required this.user,
      required this.issueId,
      required this.issueTitle,
      required this.time,
      required this.doctor,
      this.note});

  @override
  List<Object?> get props => [user, issueId, issueTitle, time, doctor, note];
}
