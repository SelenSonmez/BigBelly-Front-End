import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigBellyAppBar extends StatelessWidget {
  const BigBellyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        snap: true,
        collapsedHeight: 70,
        pinned: false,
        floating: true,
        backgroundColor: Colors.green,
        leadingWidth: 200,
        leading: SafeArea(
          child: Row(verticalDirection: VerticalDirection.up, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "Big",
                    style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(color: Colors.black),
                        fontSize: 25),
                    children: const [
                      TextSpan(
                          text: "Belly", style: TextStyle(color: Colors.white))
                    ]),
              ),
            ),
            Image.asset("assets/images/logoWithoutBackground.png")
          ]),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/defaultProfilePic.jpg'),
            ),
          ),
        ]);
  }
}
