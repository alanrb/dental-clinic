import 'package:auto_route/auto_route.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/bloc/appointment_form_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/widgets/select_case_widget.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/widgets/select_date_time_widget.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/appointment_summary_form_widget.dart';
import 'widgets/select_doctor_widget.dart';

class MakeAppointmentPage extends StatefulWidget {
  @override
  _MakeAppointmentPageState createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
  DateTime? _dateTime;
  IssueCaseModel? _issue;
  DoctorModel? _doctor;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppointmentFormBloc>(context).add(LoadCases());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _buildTitle(),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _confirmExit(context);
                },
                child: const Text(('Exit'))),
          ],
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
              })),
      body: SafeArea(child: _buildForm()),
    );
  }

  Widget _buildForm() {
    return BlocListener<AppointmentFormBloc, AppointmentFormState>(
        listener: (context, state) async {
      print('BlocListener: $state');
      if (state is Initial) {}
    }, child: BlocBuilder<AppointmentFormBloc, AppointmentFormState>(
            builder: (context, state) {
      if (state is Initial) {
        return Container();
      }
      if (state is CaseLoaded) {
        return SelectCaseWidget(
            onCaseSelected: (issueCase) {
              _issue = issueCase;
              context.read<AppointmentFormBloc>().add(CaseSelected(issueCase));
            },
            issueCases: state.cases);
      }

      if (state is DateTimeLoaded) {
        return SelectDateTimeWidget(onTimeSelected: (time) {
          _dateTime = time;
          context.read<AppointmentFormBloc>().add(DateTimeSelected(time));
        });
      }

      if (state is DoctorLoaded) {
        return SelectDoctorWidget(
            onDoctorSelected: (doctor) {
              _doctor = doctor;
              context.read<AppointmentFormBloc>().add(DoctorSelected(doctor));
            },
            doctors: state.doctor);
      }

      if (this._issue != null && _dateTime != null && _doctor != null) {
        return AppointmentSummaryFormWidget(
            issue: _issue!,
            dateTime: _dateTime!,
            doctor: _doctor!,
            onSubmitFormSuccess: () {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Appointment is submitted'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              AutoRouter.of(context).popUntilRoot();
            });
      } else {
        return Container();
      }
    }));
  }

  Widget _buildTitle() {
    return BlocListener<AppointmentFormBloc, AppointmentFormState>(
        listener: (context, state) {},
        child: BlocBuilder<AppointmentFormBloc, AppointmentFormState>(
            builder: (context, state) {
          if (state is Initial || state is CaseLoaded) {
            return Text('Step 1 of 4', style: Styles.appointmentFormTitle);
          }
          if (state is DateTimeLoaded) {
            return Text('Step 2 of 4', style: Styles.appointmentFormTitle);
          }
          if (state is DoctorLoaded) {
            return Text('Step 3 of 4', style: Styles.appointmentFormTitle);
          }
          if (state is AppointmentForm || state is Loading) {
            return Text('Step 4 of 4', style: Styles.appointmentFormTitle);
          }
          return Text('Make Appointment', style: Styles.appointmentFormTitle);
        }));
  }

  void _confirmExit(BuildContext context) {
    Navigator.of(context).pop();
  }
}
