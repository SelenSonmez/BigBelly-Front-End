import 'dart:convert';

import 'package:bigbelly/screens/follower_request/model/followerRequestModel.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../imports.dart';
import '../search/widgets/profile_tile.dart';

class FollowerRequest extends StatefulWidget {
  const FollowerRequest({Key? key}) : super(key: key);

  @override
  State<FollowerRequest> createState() => _FollowerRequestState();
}

class _FollowerRequestState extends State<FollowerRequest> {
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
          child: FutureBuilder(
              future: _fetchFollowerRequests(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProfileTile(
                          username: snapshot.data[index].account_id.toString(),
                          followerCount: 123,
                          requestId: snapshot.data[index].id,
                          updateFollowerRequests: () => setState(() {}),
                        );
                      });
                }
              }),
        )
      ]),
    );
  }

  Future _fetchFollowerRequests() async {
    dynamic id = await SessionManager().get('id');
    final uri = '/profile/$id/requests';

    try {
      Response response = await dio.get(uri);
      var requests = <FollowerRequestModel>[];
      response.data['payload']['requests'].forEach((v) {
        requests.add(FollowerRequestModel.fromJson(v));
      });
      return requests;
    } catch (_) {
      rethrow;
    }
  }
}
