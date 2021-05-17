import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pharmacypk/constant/config.dart';
import 'package:pharmacypk/model/category.dart';

import '../model/category.dart';

class ApiServices {
  Future<List<Category>> getCategories() async {
    List<Category> data =[];

    try {
      String url = Config.curl +
          Config.categoryUrl +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response =await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      if(response.statusCode==200){
        data=(response.body as List).map((e) => Category.fromJson(e),
        ).toList();
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

}
