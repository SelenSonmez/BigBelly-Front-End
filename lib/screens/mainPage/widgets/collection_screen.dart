import 'package:flutter/material.dart';

class CollectionRow extends StatelessWidget {
  const CollectionRow({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                width: 80,
                height: 80,
                "assets/images/hamburger.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outlined,
                    size: 33,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
                // IconButton(
                //   icon: Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 25,
                //   ),
                //   onPressed: () {},
                // )
              ],
            )),
          ],
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
