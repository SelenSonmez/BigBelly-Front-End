import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../../../constants/providers/user_provider.dart';
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

  String? requestID;

  void initState() {
    super.initState();
    checkSelfID();
    checkFollowingStatus();
    _isFollowerRequestSent();
  }

  @override
  void dispose() {
    isSelf;
    isFollowing;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(isFollowing);
    return Container(
      child: isSelf
          ? Container()
          : IconButton(
              onPressed: () {
                followUser();
              },
              icon: isFollowing == true
                  ? const Icon(Icons.check_rounded)
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

  void checkFollowingStatus() async {
    bool followerFound = false;
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');
    print(userValue.getUser.id);
    for (var follower in userValue.getUser.followers!) {
      if (id.toString() == follower.id.toString()) {
        userValue.setFollowingStatus = true;
        followerFound = true;
        break;
      }
    }
    userValue.getFollowingStatus ? isFollowing = true : isFollowing = false;

    setState(() {});
  }

  Future followUser() async {
    final userValue = ref.watch(userProvider);
    final id = await SessionManager().get('id');

    if (!isRequest) {
      final uri = isFollowing
          ? '/profile/followers/unfollow'
          : ('/profile/followers/follow');

      Response response = await dio.post(uri, data: {
        'account_id': id,
        'followed_account_id': userValue.getUser.id
      });

      switch (response.data['message']) {
        case 'Request needs to be Accepted':
          isRequest = true;
          break;
        case 'Request has succeed':
          if (isFollowing) {
            userValue.userUnfollowedPrivateAccount(id);
          }
          isFollowing = !isFollowing;
          userValue.setFollowingStatus = isFollowing;
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(response.data['message'])));
          break;
      }

      //if it is request remove request
      setState(() {});
    } else {
      Response response = await dio
          .post("/profile/followers/decline", data: {"request_id": requestID});
      isRequest = !isRequest;
      setState(() {});
    }
  }

  Future<bool> _isFollowerRequestSent() async {
    dynamic id = await SessionManager().get('id');
    final userValue = ref.watch(userProvider);
    final uri = '/profile/${userValue.getUser.id.toString()}/requests';

    try {
      Response response = await dio.get(uri);
      response.data['payload']['requests'].forEach((v) {
        if (id.toString() == v['account_id'].toString()) {
          requestID = v['id'].toString();
          isRequest = true;
          setState(() {});
        }
      });
    } catch (_) {
      rethrow;
    }
    return isRequest;
  }
}
