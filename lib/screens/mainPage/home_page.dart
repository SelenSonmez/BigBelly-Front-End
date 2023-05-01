import 'package:bigbelly/screens/authentication/model/user_model.dart';
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
        _controller
            .jumpTo(postIndexToBeShown * 450 + 66 * (postIndexToBeShown - 1));
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
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      return Column(children: [
                        Image.asset('assets/images/hamburger.jpg'),
                        Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: const [
                                PostitleAndTags(),
                                PostOwnerAndDate(),
                                postReactions(),
                                Divider(thickness: 2)
                              ],
                            )),
                      ]);
                    }, childCount: 10),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _getSession() async {
    dynamic id = await SessionManager().get('id');
  }
}
