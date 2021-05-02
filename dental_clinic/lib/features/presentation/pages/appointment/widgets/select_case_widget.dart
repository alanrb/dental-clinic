import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/issue_case_model.dart';
import '../../../widgets/widgets.dart';

class SelectCaseWidget extends StatefulWidget {
  SelectCaseWidget({required this.onCaseSelected, required this.issueCases});

  final void Function(IssueCaseModel issueCase) onCaseSelected;
  final List<IssueCaseModel> issueCases;

  @override
  _SelectCaseWidgetState createState() => _SelectCaseWidgetState();
}

class _SelectCaseWidgetState extends State<SelectCaseWidget> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_SelectCaseWidgetState');
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: Styles.space_m,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header('Select Case'),
                _buildListCases(widget.issueCases),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: Styles.space_m,
                width: double.infinity,
                child: StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.onCaseSelected(widget.issueCases[_value]);
                    }
                  },
                  child: Text('NEXT'),
                )))
      ],
    );
  }

  Widget _buildListCases(List<IssueCaseModel> issueCases) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, int index) => _buildCaseRow(issueCases[index], index),
      itemCount: issueCases.length,
    );
  }

  Widget _buildCaseRow(IssueCaseModel model, int index) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
            padding: Styles.space_m,
            child: ListTile(
                trailing: Radio(
                    value: index,
                    groupValue: _value,
                    onChanged: (int? currentValue) {
                      setState(() {
                        _value = index;
                      });
                    }),
                title: Text('${model.title}'),
                subtitle: Text('${model.estimation}'))));
  }
}
