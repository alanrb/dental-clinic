import 'package:auto_route/auto_route.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/register_bloc.dart';
import 'package:dental_clinic/features/presentation/routes/router.gr.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  late RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _fullNameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _fullNameController.addListener(_onFullNameChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        listener: (context, state) {
          if (state.isSubmitting) {}
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            AutoRouter.of(context).navigate(HomeRoute());
          }
          if (state.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Register Failure')],
                  ),
                  behavior: SnackBarBehavior.floating));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          builder: (context, state) {
            return Padding(
              padding: Styles.space,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: Styles.space_m.top),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email address to continue';
                          }
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          hintText: 'First & last name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your First & last name';
                          }
                          return !state.isPasswordValid
                              ? 'Invalid First & last name'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password';
                          }
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      padding: Styles.space,
                      width: double.infinity,
                      child: StyledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              isRegisterButtonEnabled(state)) {
                            _onFormSubmitted();
                          }
                        },
                        child: Text('SUBMIT'),
                        isLoading: state.isSubmitting,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(_emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(_passwordController.text.trim()));
  }

  void _onFullNameChanged() {
    _registerBloc.add(FullNameChanged(_fullNameController.text.trim()));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        fullName: _fullNameController.text.trim()));
  }
}
