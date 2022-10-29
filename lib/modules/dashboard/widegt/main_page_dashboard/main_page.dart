import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phonecheck/modules/dashboard/controller/home_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:filesize/filesize.dart';

import '../../../core/constants/const.dart';
import 'widgets/bottom_part.dart';

class MainPageDashboard extends StatelessWidget {
  const MainPageDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double middleBoxes = screenWidth / 3.75;
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 10),
                                      child: ListView(
                                        children: [
                                          Container(
                                            height: screenWidth / 2.3,
                                            width: screenWidth,
                                            padding:const EdgeInsets.only(
                                                top: 12, left: 12, right: 12),
                                            decoration: BoxDecoration(
                                                color: secondColor,
                                                borderRadius: BorderRadius.circular(
                                                    cardRadius)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Ram - ${controller.totalRam} MB Total",
                                                      style:const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      "${controller.usedRam} MB Used",
                                                      style:const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        alignment: Alignment.center,
                                                        width: screenWidth / 3,
                                                        height: screenWidth / 3,
                                                        child: SfRadialGauge(
                                                          enableLoadingAnimation:
                                                              true,
                                                          axes: <RadialAxis>[
                                                            RadialAxis(
                                                                showLabels: false,
                                                                showTicks: false,
                                                                radiusFactor: .8,
                                                                maximum: controller
                                                                    .totalRam
                                                                    .toDouble(),
                                                                canScaleToFit:
                                                                    false,
                                                                axisLineStyle:
                                                                    const AxisLineStyle(
                                                                        cornerStyle:
                                                                            CornerStyle
                                                                                .startCurve,
                                                                        thickness:
                                                                            8),
                                                                annotations: <
                                                                    GaugeAnnotation>[
                                                                  GaugeAnnotation(
                                                                      angle: 90,
                                                                      widget:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .min,
                                                                        children: <
                                                                            Widget>[
                                                                          const Text(
                                                                              'RAM',
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.white,
                                                                                  fontSize: 20)),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                2,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              '${controller.usedRamPercent}%',
                                                                              style:const TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.white,
                                                                                  fontSize: 14),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                ],
                                                                pointers: <
                                                                    GaugePointer>[
                                                                  RangePointer(
                                                                    value: controller
                                                                        .usedRam
                                                                        .toDouble(),
                                                                    width: 8,
                                                                    pointerOffset:
                                                                        0,
                                                                    cornerStyle:
                                                                        CornerStyle
                                                                            .bothFlat,
                                                                    color: const Color(
                                                                        0xFFF67280),
                                                                    gradient:const SweepGradient(
                                                                        colors: <
                                                                            Color>[
                                                                          Colors
                                                                              .white,
                                                                          Colors
                                                                              .white
                                                                        ],
                                                                        stops: <
                                                                            double>[
                                                                          0.25,
                                                                          0.75
                                                                        ]),
                                                                  ),
                                                                  // MarkerPointer(
                                                                  //   value: 136,
                                                                  //   color: Colors.white,
                                                                  //   markerType: MarkerType.circle,
                                                                  // ),
                                                                ]),
                                                          ],
                                                        )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "${controller.freeRam} MB Free",
                                                          style:const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              color: Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              ((screenWidth / 3) *
                                                                      2) -
                                                                  44,
                                                          height:
                                                              (screenWidth / 3) -
                                                                  30,
                                                          child: charts
                                                              .SfCartesianChart(
                                                            plotAreaBorderWidth: 0,
                                                            // title: charts.ChartTitle(
                                                            //     text:   'Average high/low temperature of London'),
                                                            legend: charts.Legend(
                                                                isVisible: false),
                                                            primaryXAxis: charts.CategoryAxis(
                                                                isVisible: false,
                                                                majorGridLines:
                                                                    const charts
                                                                            .MajorGridLines(
                                                                        width: 0),
                                                                labelPlacement: charts
                                                                    .LabelPlacement
                                                                    .onTicks),
                                                            primaryYAxis: charts
                                                                .NumericAxis(
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 10,
                                                                    ),
                                                                    minimum: controller
                                                                        .min
                                                                        .toDouble(),
                                                                    maximum: controller
                                                                        .max
                                                                        .toDouble(),
                                                                    // minimum:10,
                                                                    // maximum: 100,
                                                                    opposedPosition:
                                                                        true,
                                                                    axisLine: const charts
                                                                            .AxisLine(
                                                                        width: 2,
                                                                        color: Colors
                                                                            .white),
                                                                    edgeLabelPlacement:
                                                                        charts
                                                                            .EdgeLabelPlacement
                                                                            .shift,
                                                                    // labelFormat: '{value}°F',
                                                                    labelFormat: '',
                                                                    majorTickLines:
                                                                        const charts
                                                                                .MajorTickLines(
                                                                            size:
                                                                                0)),
                                                            series: controller
                                                                .getDefaultSplineSeries(),
                                                            tooltipBehavior: charts
                                                                .TooltipBehavior(
                                                                    enable: true),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "CPU Status",
                                            style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 0,
                                          ),
                                          Wrap(
                                            children: [
                                              for (var core in controller.cpuCores)
                                                cpuCore(core),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(
                                                    cardRadius),
                                                border:
                                                    Border.all(color: borderColor)),
                                            width: screenWidth,
                                            height: middleBoxes,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Internal Storage",
                                                  style: TextStyle(fontSize: 17),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: LinearPercentIndicator(
                                                        padding: EdgeInsets.all(0),
                                                        // width:
                                                        // controller.fileWidth /
                                                        //     2,
                                                        animationDuration: 1000,
                                                        lineHeight: 5.0,
                                                        percent: (100 -
                                                                    ((controller.diskFreeSpace /
                                                                                controller.diskTotalSpace) *
                                                                            100)
                                                                        .toInt())
                                                                .toDouble() /
                                                            100,
                                                        linearStrokeCap:
                                                            LinearStrokeCap
                                                                .roundAll,
                                                        progressColor: secondColor,
                                                        backgroundColor:
                                                            secondColorLight,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "${100 - ((controller.diskFreeSpace / controller.diskTotalSpace) * 100).toInt()}%",
                                                        style:const TextStyle(
                                                          fontSize: 17,
                                                        ))
                                                  ],
                                                ),
                                                Text(
                                                  "Free: ${filesize(controller.diskFreeSpace.toInt() * controller.megaByte)} GB, Total: ${filesize(controller.diskTotalSpace.toInt() * controller.megaByte)} GB",
                                                  style:const  TextStyle(
                                                      fontSize: 15,
                                                      color: greyTextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(
                                                    cardRadius),
                                                border:
                                                    Border.all(color: borderColor)),
                                            width: screenWidth,
                                            height: middleBoxes,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Battery ${controller.isInCharge ? "(charging)" : ""}",
                                                  style: TextStyle(fontSize: 17),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: controller.isInCharge
                                                          ?const  LinearProgressIndicator()
                                                          : LinearPercentIndicator(
                                                              padding:
                                                                  EdgeInsets.all(0),
                                                              // width:
                                                              // controller.fileWidth /
                                                              //     2,
                                                              animationDuration:
                                                                  1000,
                                                              lineHeight: 5.0,
                                                              percent: 0.62,
                                                              linearStrokeCap:
                                                                  LinearStrokeCap
                                                                      .roundAll,
                                                              progressColor:
                                                                  secondColor,
                                                              backgroundColor:
                                                                  secondColorLight,
                                                            ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "${controller.batteryLevel}%",
                                                        style:const  TextStyle(
                                                          fontSize: 17,
                                                        ))
                                                  ],
                                                ),
                                                Text(
                                                  "Voltage: ${controller.batteryVoltage} mV, Tempreture: ${controller.batteryTemperature} C",
                                                  style:const TextStyle(
                                                      fontSize: 15,
                                                      color: greyTextColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            cardRadius),
                                                    border: Border.all(
                                                        color: borderColor)),
                                                width: (screenWidth / 2) - 15,
                                                height: screenWidth / 6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${controller.sensorCount}",
                                                      style:const  TextStyle(
                                                          fontSize: 17,
                                                          color: textColor),
                                                    ),
                                                    const Text(
                                                      "Sensors",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: textColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            cardRadius),
                                                    border: Border.all(
                                                        color: borderColor)),
                                                width: (screenWidth / 2) - 15,
                                                height: screenWidth / 6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${controller.apps.length}",
                                                      style:const  TextStyle(
                                                          fontSize: 17,
                                                          color: textColor),
                                                    ),
                                                    const Text(
                                                      "All Apps",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: textColor),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  BottomPart()
                                ],
                              );
      }
    );
  }
   cpuCore(core) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: borderColor)),
      width: (screenWidth / 4) - 10,
      height: screenWidth / 5.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Core ${core['core']}",
            style: TextStyle(fontSize: 17, color: textColor),
          ),
          Text(
            "${core['freq']} Mhz",
            style: TextStyle(fontSize: 17, color: textColor),
          )
        ],
      ),
    );
  }
}