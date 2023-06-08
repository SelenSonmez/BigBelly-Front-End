import 'package:bigbelly/constants/providers/currentUser_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../constants/providers/user_provider.dart';
import 'mainPage/main_page_imports.dart';
import 'model/post.dart';
import 'post_details/post_details.dart';
import 'profilePage/widgets/profileHeader/profile_info.dart';

class ProfileListView extends ConsumerStatefulWidget {
  ProfileListView({super.key, this.profilePosts, this.isUserSelf = false});
  List<Post>? profilePosts = [];
  bool isUserSelf;
  @override
  ConsumerState<ProfileListView> createState() => _ProfileListViewState();
}

class _ProfileListViewState extends ConsumerState<ProfileListView> {
  int postCount = 0;
  final ScrollController _scrollController = ScrollController();
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

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    // user!.setPostCount(widget.profilePosts!.length);
    // ProfileInfo();

    var userID = ref.watch(userIDProvider);
    // var id = getID();
    return Scaffold(
        body: Center(
            child: ListView.builder(
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
