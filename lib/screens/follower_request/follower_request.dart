import '../imports.dart';

class FollowerRequest extends StatelessWidget {
  const FollowerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Follower Requests",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              const Icon(
                Icons.people,
                color: Colors.black,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ProfileTile(
                  username: ("username"),
                  followerCount: 123,
                  isRequest: true,
                );
              }),
        )
      ]),
    );
  }
}
