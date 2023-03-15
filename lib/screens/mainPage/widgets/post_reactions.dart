import 'package:bigbelly/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class postReactions extends StatelessWidget {
  const postReactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        reactionIconAndCount(Icon(Icons.favorite), true),
        reactionIconAndCount(Icon(Icons.comment), true),
        reactionIconAndCount(Icon(Icons.bookmark), false),
        reactionIconAndCount(Icon(Icons.replay_sharp), false),
        reactionIconAndCount(Icon(Icons.star), false),
      ],
    );
  }

  Widget reactionIconAndCount(Icon icon, bool isCountable) {
    return Row(
      children: [
        IconButton(
          color: mainThemeColor,
          iconSize: 23,
          icon: icon,
          onPressed: () {},
        ),
        Text(isCountable ? "2234" : " ",
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }
}
