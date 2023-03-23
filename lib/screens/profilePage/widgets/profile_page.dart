import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_header.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/profile_tabs.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            isPrivate
                ? const Icon(
                    Icons.lock_outline,
                  )
                : Container(),
            const Text("username"),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        //backgroundColor: const Color.fromARGB(255, 140, 204, 142),
      ),
      body: SafeArea(
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [ProfileHeader()];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ProfileTabs(
                  isPrivate: isPrivate,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
