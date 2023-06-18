import 'package:bigbelly/constants/providers/currentUser_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../constants/providers/user_provider.dart';
import 'mainPage/main_page_imports.dart';
import 'model/post.dart';
import 'post_details/post_details.dart';
import 'profilePage/widgets/profileHeader/profile_info.dart';

class ProfileListView extends ConsumerStatefulWidget {
  ProfileListView(
      {super.key,
      this.profilePosts,
      this.isUserSelf = false,
      required this.indexToJump});
  List<Post>? profilePosts = [];
  bool isUserSelf;
  int indexToJump = 0;
  @override
  ConsumerState<ProfileListView> createState() => _ProfileListViewState();
}

class _ProfileListViewState extends ConsumerState<ProfileListView> {
  int postCount = 0;
  final ScrollController _scrollController = ScrollController();
  final dataKey = new GlobalKey();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    ProfileInfo();
    _scrollController.addListener(_scrollListener);
  }

  getID() async {
    dynamic id = await SessionManager().get("id");
    return id;
  }

  void jumpToIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(dataKey.currentContext!);
      if (_scrollController.hasClients && index != 0) {
        /*_scrollController.jumpTo(665.1.h * index);
        print(599.1 * index);*/

        final contentSize = _scrollController.position.viewportDimension +
            _scrollController.position.maxScrollExtent -
            100;
// Estimate the target scroll position.
        final target = contentSize * index / widget.profilePosts!.length;
        print(widget.profilePosts!.length);
// Scroll to that position.
        _scrollController.position.jumpTo(
          target,
        );
      }
    });

    /* if (_scrollController.hasClients && index != 0) {
      print("girdi");
      _scrollController.jumpTo(250.0 * index);
    }
    ;*/
  }

  Size postSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var userID = ref.watch(userIDProvider);
    jumpToIndex(widget.indexToJump);

    return Scaffold(
        body: Center(
            child: ListView.builder(
      key: dataKey,
      controller: _scrollController,
      itemCount: _isLoadingMore
          ? widget.profilePosts!.length + 1
          : widget.profilePosts!.length,
      itemBuilder: (context, index) {
        if (index < widget.profilePosts!.length) {
          Post post = widget.profilePosts![index];
          post.likes!.forEach((element) {
            if (element["account_id"] == userID.getUserID) {
              post.isLiked = true;
              // widget.profilePosts.editPost(post, index);
            }
          });
          post.imageURL = "http://18.184.145.252/post/${post.id!}/image";
          return Column(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetails(
                        post: post,
                        index: index,
                      ),
                    ));
              },
              child: Image.network(
                post.imageURL!,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    PostitleAndTags(post: post),
                    PostOwnerAndDate(post: post),
                    postReactions(
                        post: post,
                        index: index,
                        isUserSelf: widget.isUserSelf),
                    Divider(thickness: 2)
                  ],
                )),
            index == widget.profilePosts!.length - 1
                ? const SizedBox(
                    height: 30,
                  )
                : const SizedBox()
          ]);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }

  void _scrollListener() {
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLoadingMore = true;
      });
      postCount = postCount + 1;

      setState(() {
        _isLoadingMore = false;
      });
    } else {}
  }
}
