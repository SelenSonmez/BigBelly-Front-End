import 'package:bigbelly/constants/Colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomIconButton(Icons.home_outlined),
          buildBottomIconButton(Icons.search_rounded),
          buildBottomIconButton(Icons.add_circle_outline),
          buildBottomIconButton(Icons.receipt_long_rounded),
        ],
      ),
    );
  }

  Widget buildBottomIconButton(IconData icon) {
    return IconButton(
      iconSize: 30,
      icon: Icon(
        icon,
        color: mainThemeColor,
      ),
      onPressed: () {},
    );
  }
}
