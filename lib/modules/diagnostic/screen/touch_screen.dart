import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';

class TouchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TouchScreenState();
}

class TouchScreenState extends State<TouchScreen> {
  int countCols = (screenWidth / 45).round();
  int countRows = ((screenHeight) / 45).round();
  double boxesCount = ((screenHeight * screenWidth) / (45 * 45));

  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();
  List selected = [];

  _selectIndex(int index) {
    if (!selected.contains(index)) {
      setState(() {
        selected.add(index);
      });
    }
    print("len ${selected.length} total ${countRows * countCols}");
    if (selected.length == countRows * countCols) {
      Get.find<TestController>().onEndTest(7, "pass");
    }
  }

  @override
  void initState() {
    Get.find<TestController>().onStartTest(7, 140);
    print(boxesCount);
    print(countCols * countCols);
    super.initState();
  }

  _detectTapedItem(PointerEvent event) {
    print(event.position);

    final RenderBox box =
        key.currentContext.findAncestorRenderObjectOfType<RenderBox>();
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        /// temporary variable so that the [is] allows access of [index]
        final target = hit.target;
        print(target);
        if (target is _Foo) {
          _selectIndex(target.index);
        }
        if (target is _Foo && !_trackTaped.contains(target)) {
          _trackTaped.add(target);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: SafeArea(
        bottom: true,
        top: true,
        child: Listener(
          onPointerDown: _detectTapedItem,
          onPointerMove: _detectTapedItem,
          child: GridView.builder(
            key: key,
            itemCount: countCols * countRows,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: countCols,
              childAspectRatio: 1.0,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (context, index) {
              return Foo(index: index, child: circularWidget(index));
              //     Container(
              //   width: 45,
              //   height: 45,
              //   color: selected.contains(index) ? Colors.red : Colors.blue,
              // );
            },
          ),
          // onPointerUp: _clearSelection,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     for (var c = 1; c < countRows; c++)
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           for (var r = 1; r < countCols; r++)
          //             circularWidget((countCols * (c - 1)) + r),
          //         ],
          //       ),
          //   ],
          // ),
        ),
      )),
    );
  }

  circularWidget(int itemSelect) {
    var height = screenHeight;
    return GestureDetector(
      onTap: () => {_selectIndex(itemSelect)},
      child: Container(
        decoration: BoxDecoration(
          color: selected.contains(itemSelect) ? Colors.red : secondColor,
          // borderRadius: BorderRadius.circular(45)
        ),
        width: 45,
        height: 45,
        padding: EdgeInsets.all(4),
      ),
    );
  }
}

class Foo extends SingleChildRenderObjectWidget {
  final int index;

  Foo({@required Widget child, @required this.index, Key key})
      : super(child: child, key: key);

  @override
  _Foo createRenderObject(BuildContext context) {
    return _Foo(index);
  }

  @override
  void updateRenderObject(BuildContext context, _Foo renderObject) {
    renderObject..index = index;
  }
}

class _Foo extends RenderProxyBox {
  int index;

  _Foo(this.index);
}
