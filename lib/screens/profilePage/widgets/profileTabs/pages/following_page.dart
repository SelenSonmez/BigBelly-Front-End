import 'package:bigbelly/screens/imports.dart';

class FollowingsPage extends StatelessWidget {
  const FollowingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 35, title: const Text("Following")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/defaultProfilePic.jpg'),
                      ),
                      title: Text("username"));
                }),
          ),
        ],
      ),
    );
  }
}
