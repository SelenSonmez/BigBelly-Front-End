import 'package:flutter/material.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(right: 3, top: 3, left: 3),
              child: Image.asset('assets/images/defaultProfilePic.jpg',
                  fit: BoxFit.cover));
        });
  }
}
