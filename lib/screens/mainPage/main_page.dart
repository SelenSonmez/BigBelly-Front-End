import 'widgets/imports.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            padding: EdgeInsets.all(18),
                            child: Column(
                              children: const [
                                PostitleAndTags(),
                                PostOwnerAndDate(),
                                postReactions(),
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
      bottomNavigationBar: NavBar(),
    );
  }
}
