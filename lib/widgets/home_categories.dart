import 'package:flutter/material.dart';

import '../constant/c_color.dart';
import '../model/category.dart';
import '../services/api_Services.dart';

class WidgetCategories extends StatefulWidget {
  @override
  _WidgetCategoriesState createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  ApiServices apiServices;

  @override
  void initState() {
    apiServices = new ApiServices();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  'All Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, top: 4),
                child: TextButton(
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PColor.primaryColor),
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
          _categoriesList(),
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
      future: apiServices.getCategories(),
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapShot) {
        if (snapShot.hasData) {
          return _buildCategoryList(snapShot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.image.url),
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 15),
                    ]),
              ),
              Row(
                children: [
                  Text(data.categoryName.toString()),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 14,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
