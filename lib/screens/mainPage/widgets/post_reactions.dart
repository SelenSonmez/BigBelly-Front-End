import 'package:bigbelly/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class postReactions extends StatelessWidget {
  const postReactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
          size: 23,
          likeCount: 121,
          likeBuilder: (isLiked) {
            final color = isLiked ? Colors.red : Colors.green;
            return Icon(Icons.favorite, color: color);
          },
        ),
        reactionIconAndCount(Icon(Icons.comment_rounded), true),
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
        Text(
          isCountable ? "2234" : " ",
        )
      ],
    );
  }
}
