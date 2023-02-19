import 'package:bigbelly/screens/form_submission_status.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  const LoginState({
    this.username = "",
    this.password = "",
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object> get props => [username, password, formStatus];
}
