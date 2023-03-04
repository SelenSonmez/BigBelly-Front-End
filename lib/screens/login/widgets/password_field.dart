import 'package:bigbelly/constants/TextFieldDecoration.dart';
import 'package:bigbelly/helpers/blocs/login/login_bloc.dart';
import 'package:bigbelly/helpers/blocs/login/login_event.dart';
import 'package:bigbelly/helpers/blocs/login/login_state.dart';
import 'package:bigbelly/providers/password_field_validator_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordTextField extends ConsumerWidget {
  PasswordTextField({Key? key, this.isPwValidate = false}) : super(key: key);

  final bool isPwValidate;

  var focusNode = FocusNode();

  late GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    focusNode.addListener(() {
      ref
          .read(passwordFieldValidatorStateProvider.notifier)
          .update((state) => focusNode.hasFocus);
    });
    return BlocBuilder<LoginBloc, LoginState>(
      builder: ((context, state) {
        return TextFormField(
          obscureText: true,
          decoration: TextFieldDecoration.AuthenticationTextFieldDecoration(
            icon: const Icon(Icons.lock_open_rounded),
            labelText: "Password",
            hintText: "Password",
          ),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
          focusNode: focusNode,
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
