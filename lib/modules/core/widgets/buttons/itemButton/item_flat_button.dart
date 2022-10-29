import 'package:flutter/material.dart';
import 'package:phonecheck/modules/core/constants/const.dart';

Widget itemFlatButton(title,{first,end,callback}){
  double height = 15;
  double width = 10;
  return InkWell(
    onTap: callback,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 3,
      horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
         defaultShadow
        ],
      ),
      padding:
      EdgeInsets.symmetric(horizontal: width, vertical: height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              first??Container(),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
              )
            ],
          ),
          end??Container()
        ],
      ),
    ),
  );
}