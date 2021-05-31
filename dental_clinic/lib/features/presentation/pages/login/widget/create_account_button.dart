import 'package:auto_route/auto_route.dart';
import 'package:dental_clinic/features/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      AutoRouter.of(context).navigate(RegisterRoute());
    }, child: Text('Create an Account'));
  }
}
