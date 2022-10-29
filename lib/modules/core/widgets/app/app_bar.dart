import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeAppBar(){
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Container(
      // width: ,
      height: 60,
      decoration: new BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
              image: new AssetImage("assets/images/logo.png"))
      ),
    ),
    // Text(
    //   "پخش چی",
    //   style: TextStyle(
    //       color: Colors.black,
    //       fontWeight: FontWeight.bold),
    // ),
    backgroundColor: Colors.white,
    brightness: Brightness.dark,
    elevation: .7,
    actionsIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.black),
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
    ],
  );
}

Widget prvHomeAppBar(){
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Container(
      // width: ,
      height: 60,
      decoration: new BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
              image: new AssetImage("assets/images/logo.png"))
      ),
    ),
    // Text(
    //   "پخش چی",
    //   style: TextStyle(
    //       color: Colors.black,
    //       fontWeight: FontWeight.bold),
    // ),
    backgroundColor: Colors.white,
    brightness: Brightness.dark,
    elevation: .7,
    actionsIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.black),
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
    ],
  );
}