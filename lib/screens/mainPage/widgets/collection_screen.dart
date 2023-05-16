import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../imports.dart';

class CollectionRow extends StatelessWidget {
  const CollectionRow(
      {super.key,
      required this.id,
      required this.title,
      this.updateCollections});
  final Function? updateCollections;
  final String title;
  final int id;

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
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            deleteCollectionDialog(context));
                  },
                )
              ],
            )),
          ],
        ),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }

  Widget deleteCollectionDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Are you sure to delete collection $title ?'),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            deleteCollection();
            Navigator.of(context).pop();
            updateCollections!();
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future deleteCollection() async {
    final uri = '/collection/$id/delete';
    Response response = await dio.post(uri);

    switch (response.data['message']) {
      case 'Request has succeed':
        print("deleted");
        /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Collection deleted!")));*/
        break;
      default:
        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));*/
        break;
    }
  }
}
