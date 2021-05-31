import 'package:dental_clinic/features/presentation/pages/login/bloc/login_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/widget/login_form_widget.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text('Sign In'),
          actions: [],
        ),
        body: Padding(
            padding: Styles.space_m,
            child: BlocProvider(
                create: (_) => sl<LoginBloc>(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[LoginForm()],
                ))));
  }
}
