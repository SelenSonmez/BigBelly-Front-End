import 'package:bigbelly/screens/mainPage/home_page.dart';
import 'package:flutter/material.dart';

class LikedPosts extends StatelessWidget {
  const LikedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(right: 3, top: 3, left: 3),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          postIndexToBeShown: index, isVisible: false)),
                ),
                child: Image.asset('assets/images/defaultProfilePic.jpg',
                    fit: BoxFit.cover),
              ));
        });
  }
}
