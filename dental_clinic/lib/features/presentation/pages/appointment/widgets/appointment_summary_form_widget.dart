import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/presentation/pages/appointment/bloc/appointment_form_bloc.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentSummaryFormWidget extends StatefulWidget {
  AppointmentSummaryFormWidget(
      {required this.issue,
      required this.dateTime,
      required this.doctor,
      required this.onSubmitFormSuccess});

  final DateTime dateTime;
  final IssueCaseModel issue;
  final DoctorModel doctor;

  final void Function() onSubmitFormSuccess;

  @override
  _AppointmentSummaryFormWidgetState createState() =>
      _AppointmentSummaryFormWidgetState();
}

class _AppointmentSummaryFormWidgetState
    extends State<AppointmentSummaryFormWidget> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_SummaryFormState');

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMMEEEEd().add_jm().format(widget.dateTime);

    return BlocListener<AppointmentFormBloc, AppointmentFormState>(
        listener: (context, state) async {
          print('BlocListener: AppointmentSummaryFormWidget state[$state]');
          if (state is AppointmentAdded) {
            _textController.clear();
            widget.onSubmitFormSuccess();
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: Styles.space_m,
              child: Form(
                  key: _formKey,
                  child: ListView(children: [
                    Header('Summary'),
                    _buildSummary(formattedDate),
                    _buildNote()
                  ])),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: Styles.space_m,
                    width: double.infinity,
                    child: _buildSubmitButton()))
          ],
        ));
  }

  Widget _buildSummary(String timeSlot) {
    return Column(children: [
      IconAndDetail(Icons.offline_pin, 'Case'),
      Card(
          child: ListTile(
        title: Text('${widget.issue.title}'),
        subtitle: Text('${widget.issue.estimation}'),
      )),
      SizedBox(height: Styles.space_m.bottom),
      IconAndDetail(Icons.person_pin, 'Doctor information'),
      Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              leading: Image.network(widget.doctor.avatar),
              title: Text(widget.doctor.fullName),
              subtitle: Text(widget.doctor.title)),
          Divider(height: 1, color: Styles.rowDivider),
          Container(
            padding: Styles.space_m,
            child: Row(
              children: [
                Expanded(
                    child: IconAndDetail(Icons.directions, 'Mekong Clinics')),
                Expanded(child: IconAndDetail(Icons.phone, '(024) 972301313'))
              ],
            ),
          ),
          Divider(height: 1, color: Styles.rowDivider),
          Container(
              padding: Styles.space_m,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date & time'),
                    Text('${timeSlot}'),
                  ])),
        ],
      )),
      SizedBox(height: Styles.space_m.bottom),
      IconAndDetail(Icons.person_pin, 'Patient information'),
      Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              title: Text('Lim Cook'),
              subtitle: Text('Patient')),
          Divider(height: 1, color: Styles.rowDivider),
          Container(
              padding: Styles.space_m,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email'),
                    Text('info@buuuk.com'),
                    SizedBox(height: Styles.space.bottom),
                    Text('Phone'),
                    Text('6590121212')
                  ]))
        ],
      )),
      SizedBox(height: Styles.space_m.bottom)
    ]);
  }

  Widget _buildNote() {
    return Column(children: [
      IconAndDetail(Icons.speaker_notes, 'Note (Optional)'),
      Card(
          child: Padding(
              padding: Styles.space_m,
              child: TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  focusNode: _focusNode,
                  decoration:
                      InputDecoration(hintText: "Enter note if needed")))),
      SizedBox(height: Styles.space_m.bottom),
      SizedBox(height: Styles.space_m.bottom),
      SizedBox(height: Styles.space_m.bottom),
      SizedBox(height: Styles.space_m.bottom),
    ]);
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AppointmentFormBloc, AppointmentFormState>(
        builder: (context, state) {
      if (state is AppointmentAdded) {
        return const Text('Appointment added');
      }
      if (state is AppointmentForm || state is Initial || state is Loading) {
        return StyledButton(
          onPressed: () => {
            context.read<AppointmentFormBloc>().add(SubmitAppointment(
                user: 'user1',
                issueId: widget.issue.id,
                issueTitle: widget.issue.title,
                time: widget.dateTime.millisecondsSinceEpoch,
                doctor: widget.doctor,
                note: _textController.text))
          },
          child: Text('SUBMIT APPOINTMENT'),
          isLoading: state is Loading,
        );
      }
      if (state is AppointmentFormError) {
        return Text(state.message);
      }
      return const Text('Something went wrong!');
    });
  }
}
