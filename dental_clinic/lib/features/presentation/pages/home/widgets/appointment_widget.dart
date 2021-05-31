import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentAppointment extends StatelessWidget {
  final List<AppointmentModel> datum;

  const RecentAppointment({required this.datum});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header('Appointment'),
        SizedBox(height: Styles.space.bottom),
        Card(child: _buildList(datum)),
        SizedBox(height: Styles.space_l.bottom),
        SizedBox(height: Styles.space_l.bottom),
        SizedBox(height: Styles.space_l.bottom)
      ],
    );
  }

  Widget _buildList(List<AppointmentModel> appointments) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, int index) => _buildRow(
            appointments[index], index, index == appointments.length - 1),
        itemCount: appointments.length);
  }

  Widget _buildRow(AppointmentModel model, int index, bool lastItem) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(model.time);
    String formattedDate = DateFormat.yMMMMEEEEd().add_jm().format(dateTime);

    final row = ListTile(
        title: Text('${model.issueTitle}'), subtitle: Text('$formattedDate'));

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Divider(height: 1),
      ],
    );
  }
}
