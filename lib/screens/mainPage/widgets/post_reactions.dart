import 'package:bigbelly/constants/colors.dart';
import 'package:bigbelly/screens/mainPage/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:like_button/like_button.dart';

import '../../../constants/dio.dart';

class postReactions extends StatelessWidget {
  postReactions({super.key});
  int count = 1;

  void like() async {
    String id = await SessionManager().get('id');

    Map<String, dynamic> params = <String, dynamic>{
      'post_id': 5,
      'account_id': id,
    };
    //unlike
    if (count % 2 == 0) {
      debugPrint("unlike");
      final response = await dio.post('/post/unlike', data: params);
      debugPrint(response.data.toString());
      count++;
      return;
    }
    //like
    debugPrint("like");
    final response = await dio.post('/post/like', data: params);
    debugPrint(response.data.toString());
    count++;
  }

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
            onTap: _onLikeButtonTapped),
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

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    like();
    return !isLiked;
  }
}
