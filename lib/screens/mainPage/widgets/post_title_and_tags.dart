import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/post.dart';

class PostitleAndTags extends ConsumerWidget {
  PostitleAndTags({super.key, required this.post});
  Post post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          post.title!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        post.tags!.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300),
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag_outlined,
                      size: 27,
                    ),
                    Text(post.tags!.first.tagName,
                        style: const TextStyle(fontSize: 16)),
                    post.tags!.length > 1
                        ? Text(", ${post.tags![1].tagName}",
                            style: const TextStyle(fontSize: 16))
                        : const SizedBox()
                  ],
                ))
            : Container()
      ]),
    );
  }
}
