

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pharmacypk/widgets/home_categories.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: Colors.white,
          child: ListView(
            children: [
              imageCarousel(context),
              WidgetCategories(),

            ],
          ),
    ));
  }
}
Widget imageCarousel(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: Carousel(
      overlayShadow: false,
      borderRadius: true,
      boxFit: BoxFit.none,
      autoplay: true,
      dotSize: 4.0,
      images: [
        FittedBox(fit: BoxFit.fill,child: Image.network("https://mypharmacy.pk/wp-content/uploads/2020/09/WHATSMEDI-1-1.jpg"),),
        FittedBox(fit: BoxFit.fill,child: Image.network("https://mypharmacy.pk/wp-content/uploads/2020/05/s3.jpg"),),
        FittedBox(fit: BoxFit.fill,child: Image.network("https://mypharmacy.pk/wp-content/uploads/2020/05/s1.jpg"),),

      ],

    ),

  );
}
