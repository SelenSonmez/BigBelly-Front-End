import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../../../constants/providers/user_provider.dart';
import '../../../follower_request/model/followerRequestModel.dart';
import '../../../imports.dart';

class UserFollowingStatus extends ConsumerStatefulWidget {
  const UserFollowingStatus({super.key});

  @override
  ConsumerState<UserFollowingStatus> createState() =>
      _UserFollowingStatusState();
}

class _UserFollowingStatusState extends ConsumerState<UserFollowingStatus> {
  bool isFollowing = false;
  bool isSelf = false;
  bool isRequest = false;

  void initState() {
    super.initState();
    checkSelfID();
    checkFollowingStatus();
    isFollowerRequest();
  }

  @override
  void dispose() {
    isSelf;
    isFollowing;
    isRequest;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSelf
          ? Container()
          : IconButton(
              onPressed: () {
                followUser();
              },
              icon: isFollowing
                  ? const Icon(Icons.person_add_disabled_outlined)
                  : (isRequest
                      ? const Icon(Icons.lock_clock_outlined)
                      : const Icon(Icons.person_add_alt_outlined)),
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

  //check if the user is following the searched account
  Future checkFollowingStatus() async {
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');

    for (var follower in userValue.getUser.followers!) {
      if (id == follower.id.toString()) {
        isFollowing = true;
        break;
      }
    }
    setState(() {});
  }

  Future followUser() async {
    final userValue = ref.watch(userProvider);
    final id = await SessionManager().get('id');

    final uri = isFollowing
        ? '/profile/followers/unfollow'
        : (isRequest
            ? ('/profile/followers/cancel-follow-request')
            : ('/profile/followers/follow'));

    Response response = await dio.post(uri,
        data: {'account_id': id, 'followed_account_id': userValue.getUser.id});

    if (!isRequest) {
      switch (response.data['message']) {
        case 'Request needs to be Accepted':
          isRequest = true;
          break;
        case 'Request has succeed':
          checkFollowingStatus();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(response.data['message'])));
          break;
      }
    } else {
      switch (response.data['message']) {
        case 'Request has succeed':
          isFollowerRequest();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(response.data['message'])));
          break;
      }
    }
    setState(() {});
  }

  //check if the user has sent a follow request to the searched account
  Future isFollowerRequest() async {
    isRequest = false;
    final userValue = ref.read(userProvider);
    dynamic id = await SessionManager().get('id');

    final followedAccountID = userValue.getUser.id.toString();
    final uri = '/profile/$followedAccountID/requests';
    try {
      Response response = await dio.get(uri);
      for (var request in response.data['payload']['requests']) {
        if (request['account_id'].toString() == id) {
          isRequest = true;
          setState(() {});
          break;
        }
      }
    } catch (_) {
      rethrow;
    }
  }
}
