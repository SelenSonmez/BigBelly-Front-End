import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../imports.dart';
import 'widgets/big_belly_dropdown.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        children: [IncrementButton(), BigBellyDropdown()],
      ),
    ));
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 60,
            height: 45,
            margin: const EdgeInsets.all(15.0),
            // padding: const EdgeInsets.all(,.0),
            child: TextField(
              keyboardType: TextInputType.number,
            )),
      ],
    );
  }
}
