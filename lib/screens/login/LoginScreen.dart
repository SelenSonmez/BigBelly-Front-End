import 'package:bigbelly/helpers/blocs/login/login_state.dart';
import 'package:bigbelly/repository/auth/login/login_repository.dart';
import 'package:bigbelly/screens/form_submission_status.dart';
import 'package:bigbelly/screens/login/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/Colors.dart';
import '../../helpers/blocs/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<LoginRepository>()),
        child: BlocListener<LoginBloc, LoginState>(
            listenWhen: ((previous, current) =>
                previous.formStatus != current.formStatus),
            listener: (context, state) {
              final formStatus = state.formStatus;

              if (formStatus is SubmissionFailed) {
                showMessage(context, formStatus.exception.toString());
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(tag: "logo", child: logoImage),
                    LoginFormWidget()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
