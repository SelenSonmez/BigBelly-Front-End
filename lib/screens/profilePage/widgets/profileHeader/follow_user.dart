import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../../../constants/providers/user_provider.dart';

class UserFollowingStatus extends ConsumerStatefulWidget {
  const UserFollowingStatus({super.key});

  @override
  ConsumerState<UserFollowingStatus> createState() =>
      _UserFollowingStatusState();
}

class _UserFollowingStatusState extends ConsumerState<UserFollowingStatus> {
  bool isFollowing = false;
  bool isSelf = false;

  void initState() {
    super.initState();
    checkSelfID();
  }

  @override
  void dispose() {
    isSelf;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSelf
          ? Container()
          : IconButton(
              onPressed: () {
                setState(() {
                  isFollowing = !isFollowing;
                });
              },
              icon: isFollowing
                  ? const Icon(Icons.person_add_disabled_outlined)
                  : const Icon(Icons.person_add_alt_outlined),
            ),
    );
  }

  Future<bool> checkSelfID() async {
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');
    isSelf = (id == userValue.getUser.id.toString()) ? true : false;

    setState(() {});

    return isSelf;
  }
}
