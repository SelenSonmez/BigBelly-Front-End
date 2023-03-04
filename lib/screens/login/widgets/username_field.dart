import 'package:bigbelly/constants/TextFieldDecoration.dart';
import 'package:bigbelly/helpers/blocs/login/login_bloc.dart';
import 'package:bigbelly/helpers/blocs/login/login_event.dart';
import 'package:bigbelly/helpers/blocs/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: ((context, state) {
        return TextFormField(
          obscureText: false,
          decoration: TextFieldDecoration.AuthenticationTextFieldDecoration(
            icon: const Icon(Icons.account_circle_rounded),
            labelText: "Username",
            hintText: "Username",
          ),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginUsernameChanged(username: value)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        );
      }),
    );
  }
}
