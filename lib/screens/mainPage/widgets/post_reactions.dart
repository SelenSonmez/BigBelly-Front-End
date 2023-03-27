import 'package:bigbelly/constants/colors.dart';
import 'package:bigbelly/screens/mainPage/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class postReactions extends StatelessWidget {
  const postReactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
          size: 23.h,
          likeCount: 121,
          likeBuilder: (isLiked) {
            final color = isLiked ? Colors.red : Colors.green;
            return Icon(Icons.favorite, color: color);
          },
        ),
        reactionIconAndCount(
            const Icon(Icons.comment_rounded), true, context, "comment"),
        reactionIconAndCount(
            const Icon(Icons.bookmark), false, context, "bookmark"),
        reactionIconAndCount(
            const Icon(Icons.replay_sharp), false, context, "recipe"),
        reactionIconAndCount(const Icon(Icons.star), false, context, "star"),
      ],
    );
  }

  Widget reactionIconAndCount(
      Icon icon, bool isCountable, context, String type) {
    return Row(
      children: [
        IconButton(
          color: mainThemeColor,
          iconSize: 23.h,
          icon: icon,
          onPressed: () {
            switch (type) {
              case "comment":
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CommentScreen())));
                break;
              case "bookmark":
                break;
              case "recipe":
                break;
              case "star":
                break;
            }
          },
        ),
        Text(
          isCountable ? "2234" : " ",
        )
      ],
    );
  }
}
