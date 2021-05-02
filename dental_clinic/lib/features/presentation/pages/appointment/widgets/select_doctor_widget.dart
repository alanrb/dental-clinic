import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SelectDoctorWidget extends StatefulWidget {
  SelectDoctorWidget({required this.onDoctorSelected, required this.doctors});

  final void Function(DoctorModel doctor) onDoctorSelected;
  final List<DoctorModel> doctors;

  @override
  _SelectDoctorWidgetState createState() => _SelectDoctorWidgetState();
}

class _SelectDoctorWidgetState extends State<SelectDoctorWidget> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_SelectDoctorWidgetState');
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Header('Select Doctor'),
          Padding(
            padding: Styles.space_m,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(child: _buildListCases(widget.doctors)),
                  SizedBox(height: Styles.space_m.bottom),
                ],
              ),
            ),
          )
        ]),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: Styles.space_m,
                width: double.infinity,
                child: StyledButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {widget.onDoctorSelected(widget.doctors[_value])}
                  },
                  child: Text('NEXT'),
                )))
      ],
    );
  }

  Widget _buildListCases(List<DoctorModel> doctors) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, int index) =>
            _buildRow(doctors[index], index, index == doctors.length - 1),
        itemCount: doctors.length);
  }

  Widget _buildRow(DoctorModel model, int index, bool lastItem) {
    final row = ListTile(
        leading: Image.network(model.avatar),
        title: Text('${model.fullName}'),
        subtitle: Text('${model.title}'),
        trailing: Radio(
            value: index,
            groupValue: _value,
            onChanged: (int? currentValue) {
              setState(() {
                _value = index;
              });
            }));

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
