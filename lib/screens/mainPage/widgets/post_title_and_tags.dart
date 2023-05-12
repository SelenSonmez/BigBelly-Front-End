import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostitleAndTags extends ConsumerWidget {
  const PostitleAndTags({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var post = ref.watch(postProvider).getPost;
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          post.title!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(
          color: Colors.grey.shade300,
          child: post.tags != null
              ? ListView.builder(
                  itemCount: post.tags!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Icon(Icons.flag_outlined),
                      Text(post.tags![index].toString()),
                    ]);
                  },
                )
              : Container(),
        )
      ]),
    );
  }
}
