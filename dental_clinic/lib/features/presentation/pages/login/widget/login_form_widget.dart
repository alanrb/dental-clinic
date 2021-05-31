import 'package:auto_route/auto_route.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/bloc/login_bloc.dart';
import 'package:dental_clinic/features/presentation/pages/login/widget/create_account_button.dart';
import 'package:dental_clinic/features/presentation/routes/router.gr.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_LoginFormState');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure')],
                  ),
                  behavior: SnackBarBehavior.floating));
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            AutoRouter.of(context).navigate(HomeRoute());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: _loginBloc,
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: Styles.space_m,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your email address to continue';
                              }
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
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
                          SizedBox(height: Styles.space_m.top),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              width: double.infinity,
                              child: StyledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      isLoginButtonEnabled(state)) {
                                    _onFormSubmitted();
                                  }
                                },
                                isLoading: state.isSubmitting,
                                child: Text('SIGN IN'),
                              )),
                          Container(
                            width: double.infinity,
                            child: CreateAccountButton(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
