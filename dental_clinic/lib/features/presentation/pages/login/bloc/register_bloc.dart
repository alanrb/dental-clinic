import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dental_clinic/features/domain/usecases/user/register_usecase.dart';
import 'package:dental_clinic/features/presentation/Validators.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc(this._registerUseCase) : super(RegisterState.empty());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => (event is! EmailChanged &&
        event is! PasswordChanged &&
        event is! FullNameChanged));
    final debounceStream = events
        .where((event) => (event is EmailChanged ||
            event is PasswordChanged ||
            event is FullNameChanged))
        .debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
        MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is FullNameChanged) {
      yield* _mapFullNameChangedToState(event.fullName);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.email, event.password, event.fullName);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapFullNameChangedToState(String fullName) async* {
    yield state.update(isFullNameValid: fullName.trim().length > 0);
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email, String password, String fullName) async* {
    yield RegisterState.loading();
    try {
      var result = await _registerUseCase(
          RegisterParam(email: email, password: password, fullName: fullName));
      yield result.fold((failure) => RegisterState.failure(),
          (user) => RegisterState.success());
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
