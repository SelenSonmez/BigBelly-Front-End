import 'package:bigbelly/helpers/blocs/login/login_event.dart';
import 'package:bigbelly/helpers/blocs/login/login_state.dart';
import 'package:bigbelly/repository/auth/login/login_repository.dart';
import 'package:bigbelly/screens/form_submission_status.dart';
import 'package:bigbelly/screens/login/widgets/form_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository? authRepo;

  Map<String, dynamic> fields = {};

  LoginBloc({this.authRepo}) : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
      addFields('username', event.username);
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
      addFields('password', event.password);
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo?.login(fields);

        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }

  void addFields(String name, String? value) {
    fields[name] = value;
  }
}
