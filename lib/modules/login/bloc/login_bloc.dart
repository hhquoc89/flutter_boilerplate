import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_boilerplate/modules/respositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepositories userRepositories;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepositories, required this.authenticationBloc})
      : assert(userRepositories != null),
        assert(authenticationBloc != null),
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          final token =
              await userRepositories.login(event.userName, event.password);
          authenticationBloc.add(LoggedIn(token: token));
          emit(LoginInitial());
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}
