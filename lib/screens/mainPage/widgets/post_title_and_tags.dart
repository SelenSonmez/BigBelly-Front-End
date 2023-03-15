import 'package:flutter/material.dart';

class PostitleAndTags extends StatelessWidget {
  const PostitleAndTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          "Juicy Hamburger",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(
          color: Colors.grey.shade300,
          child: Row(children: const [
            Icon(Icons.flag_outlined),
            Text("Vegan,"),
            Text(" Glutensiz")
          ]),
        )
      ]),
    );
  }
}
