import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmacypk/constant/c_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen.dart';

class Data {
  final String text;
  final String imageUrl;

  Data({this.text, this.imageUrl});
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment(0, 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0, index == 0 ? Colors.green : PColor.primaryColor),
            buildContainer(1, index == 1 ? Colors.green : PColor.primaryColor),
            buildContainer(2, index == 2 ? Colors.green : PColor.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int i, Color color) {
    return index == i
        ? Icon(Icons.star)
        : Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          );
  }
}

int currentState = 0;

class PageViewer extends StatefulWidget {
  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  List<Data> myData = [
    Data(
      text: "View & Buy Medicine \n Online",
      imageUrl: "assets/images/p2.png",
    ),
    Data(
      text: "Save your time with us",
      imageUrl: "assets/images/p3.png",
    ),
    Data(
      text: "We Provide Home \n Delivery",
      imageUrl: "assets/images/p1.png",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Builder(
            builder: (ctx) => PageView(
              controller: _controller,
              onPageChanged: (val) {
                setState(() {
                  currentState = val;
                });
              },
              children: myData
                  .map((item) => Stack(
                        children: [
                          Positioned(
                            top: 190,
                            left: 40,
                            child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: PColor.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned(
                            top: 250,
                            right: 100,
                            child: Container(
                              height: 200,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: PColor.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned(
                              top: 310,
                              right: 130,
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ExactAssetImage(item.imageUrl),
                                  )))),
                          Positioned(
                            top: 460,
                            right: 80,
                            child: Container(
                                child: Text(
                              item.text,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
          Positioned(top: 550, right: 170, child: Indicator(currentState)),
          Positioned(
            bottom: 170,
            left: 55,
            child: Builder(
              builder: (ctx) => Align(
                alignment: Alignment(0, 0.93),
                child: Container(
                  width: 270,
                  decoration: BoxDecoration(),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () async{

                      Navigator.pushReplacement(ctx,
                          MaterialPageRoute( builder: (_) => AuthScreen()));

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('pageV', true);


                    },
                    color: PColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

