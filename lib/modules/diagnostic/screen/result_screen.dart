import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/diagnostic/controller/diagnostic_controller.dart';

import '../../core/constants/const.dart';
import '../model/test.dart';
import 'diagnostic_screen.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<int> openedCategories = [100];
  int specialIndex;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.85;

    @override
    void initState() {
      super.initState();
      Get.isDialogOpen ? Get.back(closeOverlays: true) : null;
      Get.back();
    }

    return Scaffold(
        body: GetBuilder<DiagnosticController>(builder: (controller) {
      return SafeArea(
        top: true,
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 15,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF262626),
                borderRadius: BorderRadius.circular(cardRadius),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                "Result Screen",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight,
                child: ListView.builder(
                  itemCount:   controller.testGroup.length,
                
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<Test> categoryTest = controller.check.tests
                        .where((i) => i.category == controller.testGroup[index])
                        .toList();

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              !openedCategories.contains(index)
                                  ? openedCategories.add(index)
                                  : openedCategories.remove(index);
                            });
                          },
                          child: Container(
                            height: height / 14,
                            width: width,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.green,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                 controller.testGroup[index].toString(),
                                 
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                                Icon(
                                  !openedCategories.contains(index)
                                      ? Icons.keyboard_arrow_down_sharp
                                      : Icons.keyboard_arrow_up_sharp,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        openedCategories.contains(index)
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        cardRadius),
                                                border: Border.all(
                                                    color: borderColor)),
                                            width: screenWidth,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const FixedExtentScrollPhysics (),
                                                itemCount:     categoryTest.length,
                                            
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Test test = Test(
                                                      id: categoryTest[index]
                                                          .id,
                                                      title: categoryTest[index]
                                                          .title,
                                                      status:
                                                          categoryTest[index]
                                                              .status);
                                                

                                                  return simpleTestItem(
                                                      test, index);
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
