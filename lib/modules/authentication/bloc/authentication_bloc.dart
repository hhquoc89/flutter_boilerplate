import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/modules/respositories/repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepositories userRepositories;

  AuthenticationState get initialState => AuthenticationUninitialized();
  AuthenticationBloc({required this.userRepositories})
      : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>(((event, emit) async {
      if (event is AppStarted) {
        final String getToken = await userRepositories.getToken();
        if (getToken == '') {
          emit(AuthenticationUnauthenticated());
        }
        emit(AuthenticationAuthenticated());
      }
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await userRepositories.persistToken(event.token);
        emit(AuthenticationAuthenticated());
      }
      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await userRepositories.deleteToken();
        emit(AuthenticationUnauthenticated());
      }
    }));
  }
}
