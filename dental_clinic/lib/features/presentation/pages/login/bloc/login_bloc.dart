import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dental_clinic/features/domain/usecases/user/sign_in_with_credentials_usecase.dart';
import 'package:dental_clinic/features/presentation/Validators.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInWithCredentialsUseCase signInWithCredentialsUseCase;

  LoginBloc(this.signInWithCredentialsUseCase) : super(LoginState.empty());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    final nonDebounceStream = events.where(
        (event) => (event is! EmailChanged && event is! PasswordChanged));
    final debounceStream = events
        .where((event) => (event is EmailChanged || event is PasswordChanged))
        .debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
        MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginCredentialsPressedToState(event.email, event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginState.failure();
  }

  Stream<LoginState> _mapLoginCredentialsPressedToState(
      String email, String password) async* {
    yield LoginState.loading();
    try {
      await signInWithCredentialsUseCase
          .call(SignInWithCredentialsParam(email: email, password: password));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
