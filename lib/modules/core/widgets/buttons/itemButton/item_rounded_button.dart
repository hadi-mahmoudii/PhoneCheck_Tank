import 'package:flutter/material.dart';

Widget itemRoundedButton(title,{callback,first,end}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          spreadRadius: 0.1,
          blurRadius: 9,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: InkWell(
      onTap:  callback,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  child:first??Container()
                ),
                SizedBox(
                  width: 9,
                ),
                Text(title)
              ],
            ),
            // Text("${category.childCount}")
            end??Container()
          ],
        ),
      ),
    ),
  );
}