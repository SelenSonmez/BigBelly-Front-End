import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = "Big Belly";
    return Scaffold(
        appBar: AppBar(
          leading: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                      style: GoogleFonts.patrickHand(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      "Big"),
                  Text(
                      style: GoogleFonts.patrickHand(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade900),
                      "Belly"),
                  Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                      scale: 2,
                    ),
                  ),
                ],
              )),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 15),
              child: Row(
                children: [
                  const Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      "Recommendation History"),
                  Container(
                      padding: EdgeInsets.only(left: 25),
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
                height: 150,
                child: Center(
                    child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                              Text(
                                  style: TextStyle(color: Colors.white), "1000")
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                        // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        //Recipe Title
                        Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            "Recipe Title"),
                        Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            "By: Recipe creator's name"),
                      ],
                    ))
                  ],
                )),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Get Recommendation"))
          ],
        )));
  }
}
