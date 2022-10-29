import 'package:flutter/material.dart';

import '../../core/constants/const.dart';

simpleListItem(title, subTitle, {hasDivider = true}) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style:const  TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: textColor),
          ),
          Text(
            subTitle,
            style: const TextStyle(color: textColor),
          ),
          const SizedBox(
            height: 5,
          ),
          hasDivider
              ? Container(
                  width: screenWidth,
                  height: 1,
                  color: borderColor,
                )
              : Container()
        ],
      ),
    );
  }