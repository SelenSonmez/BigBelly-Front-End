import 'package:bigbelly/constants/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = "Big Belly";
    return Scaffold(
        appBar: AppBar(
          title: Text("Recommendation"),
          leading: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  // Text(
                  //     style: GoogleFonts.patrickHand(
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.white),
                  //     "Big"),
                  // Text(
                  //     style: GoogleFonts.patrickHand(
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.green.shade900),
                  //     "Belly"),
                  // Container(
                  //   child: Image.asset(
                  //     'assets/images/logo.png',
                  //     scale: 2,
                  //   ),
                  // ),
                ],
              )),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 75, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      "Recommendation History"),
                  Container(
                      // padding: EdgeInsets.only(left: 25),
                      child: Text(
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          "See All"))
                ],
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(
                width: 350,
                height: 175,
                child: Center(
                    child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(50), // Image radius
                                child: Image.network(
                                    'https://images.unsplash.com/photo-1565976469782-7c92daebc42e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          //Likes
                          Container(
                              child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                  color: Colors.white,
                                  size: 20,
                                  Icons.thumb_up_outlined),
                              Text(style: TextStyle(color: Colors.white), "35")
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            //Recipe Title
                            Text(
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                "Vegan Noodle"),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                "By: Chef Ramsay"),
                          ],
                        ))
                  ],
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Get Recommendation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      dynamic id = await SessionManager().get("id");
                      final response =
                          await dio.get("/recommendation?account_id=$id");
                      print(response.data);
                    },
                    child: Text("For Self")),
                ElevatedButton(onPressed: () {}, child: Text("For Group")),
              ],
            )
          ],
        )));
  }
}
