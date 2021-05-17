import 'package:flutter/material.dart';
import 'package:pharmacypk/screens/dashboard.dart';
import 'package:pharmacypk/screens/profile.dart';

import '../constant/c_color.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index=0;

  List<Widget>_widgetList=[
    DashBoard(),
    UserProfile(),
    UserProfile(),
    UserProfile(),

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Store',style: TextStyle(),)),
          BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('Category',style: TextStyle(),)),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline),title: Text('Pers',style: TextStyle(),)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),title: Text('Profile',style: TextStyle(),)),

        ],
        selectedItemColor:PColor.primaryColor ,
        unselectedItemColor:Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex:_index,
        onTap: (index){
          setState(() {
            _index=index;
          });
        },

      ),
      body: _widgetList[_index],
    );
  }

 Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: PColor.primaryColor,
      automaticallyImplyLeading: false,
      title: Text("My Pharmacy.pk",style: TextStyle(color: Colors.white),),
      actions: [
        IconButton(icon: Icon(Icons.notifications_none,color: Colors.amber,), onPressed: null),
        SizedBox(width: 5,),
        IconButton(icon: Icon(Icons.shopping_cart,color: Colors.amber), onPressed: null),

      ],
    );
 }
}
