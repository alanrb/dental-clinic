import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dental_clinic/core/usecases/usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/get_user_usecase.dart';
import 'package:dental_clinic/features/domain/usecases/user/signout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserUseCase getUserUseCase;
  final SignOutUseCase signOutUseCase;

  AuthenticationBloc(this.getUserUseCase, this.signOutUseCase)
      : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final failureOrResult = await getUserUseCase(NoParams());
    yield failureOrResult.fold(
        (failure) => Unauthenticated(), (user) => Authenticated());
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    signOutUseCase(NoParams());
  }
}
