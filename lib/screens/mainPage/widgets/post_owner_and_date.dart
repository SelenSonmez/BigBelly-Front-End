import 'package:flutter/material.dart';

class PostOwnerAndDate extends StatelessWidget {
  const PostOwnerAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //owner avatar and name
          Row(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20.0,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/defaultProfilePic.jpg'),
                  radius: 18.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Somer Şef"),
              ),
            ],
          ),
          const Text("2 days ago")
        ],
      ),
    );
  }
}
