import 'package:bigbelly/constants/TextFieldDecoration.dart';
import 'package:bigbelly/helpers/blocs/login/login_bloc.dart';
import 'package:bigbelly/helpers/blocs/login/login_event.dart';
import 'package:bigbelly/helpers/blocs/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: ((context, state) {
        return TextFormField(
          obscureText: true,
          decoration: TextFieldDecoration.AuthenticationTextFieldDecoration(
            icon: const Icon(Icons.password_rounded),
            labelText: "Password",
            hintText: "Password",
          ),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      }),
    );
  }
}
