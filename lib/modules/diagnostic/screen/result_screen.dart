import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';

import '../../core/constants/const.dart';
import '../../dashboard/widegt/simple_list_item.dart';
import '../model/test.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: GetX<DiagnosticController>(builder: (controller) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: screenWidth,
                height: screenHeight / 15,
                decoration: BoxDecoration(
                  color: Color(0xFF262626),
                  borderRadius: BorderRadius.circular(cardRadius),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: const Text(
                  "Results",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(cardRadius),
                        border: Border.all(color: borderColor)),
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.testGroup.length,
                          itemBuilder: (BuildContext context, int index) {
                            Test test = controller.testGroup[index];
                            return GestureDetector(
                              onTap: () {},
                              child:Column(children: [
simpleListItem(test, index) ,
// resultItemWidget(controller.categoryTests.length)
                              ],)  
                            );
                    
                           
                          }),
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        );
      }),
    ));
  }
}



// resultItemWidget(int lenght , ){
//   return Column(children: [
//     ListView.builder(
//       itemCount: lenght,
//       itemBuilder: ((context, index) {
//       return simpleListItem(title, subTitle)
//     }))
//   ],);
// }