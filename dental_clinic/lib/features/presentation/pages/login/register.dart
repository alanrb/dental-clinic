import 'package:dental_clinic/features/presentation/pages/login/widget/register_form_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: RegisterForm(),
    );
  }
}