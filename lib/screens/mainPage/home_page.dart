import 'package:bigbelly/screens/authentication/model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'main_page_imports.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    _getSession();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [const BigBellyAppBar()];
        },
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
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
    data = await SessionManager().get("user");
  }
}
