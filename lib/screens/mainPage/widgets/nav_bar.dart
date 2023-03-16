import 'package:bigbelly/constants/Colors.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
      focusColor: Colors.red,
      iconSize: 30,
      icon: Icon(
        icon,
        color: mainThemeColor,
      ),
      onPressed: () {},
    );
  }
}
