import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserFollowingStatus extends StatefulWidget {
  const UserFollowingStatus({super.key});

  @override
  State<UserFollowingStatus> createState() => _UserFollowingStatusState();
}

class _UserFollowingStatusState extends State<UserFollowingStatus> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFollowing = !isFollowing;
        });
      },
      icon: isFollowing
          ? const Icon(Icons.person_add_disabled_outlined)
          : const Icon(Icons.person_add_alt_outlined),
    );
  }
}
