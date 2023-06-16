import 'package:bigbelly/screens/imports.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'texts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Report),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 120.0, 40, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                textAlign: TextAlign.center,
                About,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
