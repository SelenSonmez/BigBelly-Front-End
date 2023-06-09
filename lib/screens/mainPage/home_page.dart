import 'package:bigbelly/screens/authentication/model/user_model.dart';
import 'package:bigbelly/screens/post_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'main_page_imports.dart';

class HomePage extends StatelessWidget {
  HomePage({this.postIndexToBeShown = 0, this.isVisible = true, super.key});

  final ScrollController _controller = ScrollController();
  late final int id;
  bool isVisible;
  int postIndexToBeShown;

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients && postIndexToBeShown != 0) {
        _controller.jumpTo(postIndexToBeShown * 662.7.h);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollDown();
    _getSession();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return isVisible ? [BigBellyAppBar()] : [];
        },
        body: Center(child: PostListView()),
      ),
    );
  }

  _getSession() async {
    dynamic id = await SessionManager().get('id');
  }
}
