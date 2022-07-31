import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double pressureValu = 20;
  // bool pressureEnable = true;
  // bool levelEnable = true;
  // double levelValu = 20;

  bool lamp1 = false;
  bool lamp2 = false;
  bool lamp3 = false;
  bool lamp4 = false;
  bool lamp5 = false;
  bool lamp6 = false;
  bool lamp7 = false;
  bool lamp8 = false;

  Offset of1 = const Offset(0, 0);
  Offset of2 = const Offset(0, 0);
  double time = 0.001;
  double speed = 0;
  double acc = 0;

  void calculate() {
    // double s = (of1.dy - of2.dy) / (of1.dx - of2.dy);
    double distance =
        sqrt(pow((of1.dy - of2.dy), 2) + pow((of1.dx - of2.dx), 2));
    speed = distance / time;
    acc = speed / time;
    print("Speed : $speed \n================================");
    print("Acc : $acc \n================================");
    of2 = of1;
  }

  double xAxisMous = 0;
  double yAxisMous = 0;
  double distance = 0;
  int time2 = 0;

  List<LogicalKeyboardKey> keys = [];
  Timer? timer;
  var key;

  // double volcity({double? x1, double? y1, double? x2, double? y2}) {
  //   return sqrt(pow(x2!, 2) - pow(x1!, 2) + pow(y2!, 2) - pow(y1!, 2));
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        key = event.logicalKey;
        if (keys.contains(key)) return;
        if (event is RawKeyDownEvent) {
          setState(() => keys.clear());
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            print("${key.debugName}");
          }
          setState(() => keys.add(key));
          if (keys.contains(LogicalKeyboardKey.controlLeft) &&
              keys.contains(LogicalKeyboardKey.keyC)) {
            print("Control+C Pressed");
          }
        } else {
          setState(() => keys.remove(key));
        }
      },
      child: MouseRegion(
        onEnter: (e) {
          print("${e.position} Enter point");
        },
        onHover: (e) {
          of1 = e.position;
          calculate();
          setState(() {

            print(e.position.dx);
            print(e.position.dy);
            xAxisMous = e.position.dx;
            yAxisMous = e.position.dy;
            distance = e.position.distance;
            time2 = e.timeStamp.inSeconds;
          });
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "X Axis",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Center(
                                  child: Container(
                                width: 200,
                                child: SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 3500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 2000,
                                          pointers: <GaugePointer>[
                                            NeedlePointer(value: xAxisMous)
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                                widget: Container(
                                                    child: Text(
                                                        '${xAxisMous.round()}',
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                angle: 90,
                                                positionFactor: 0.5)
                                          ])
                                    ]),
                              )),

                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Y Axis",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Center(
                                  child: Container(
                                width: 200,
                                child: SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 3500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 1000,
                                          pointers: <GaugePointer>[
                                            NeedlePointer(value: yAxisMous)
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                                widget: Container(
                                                    child: Text(
                                                        '${yAxisMous.round()}',
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                angle: 90,
                                                positionFactor: 0.5)
                                          ])
                                    ]),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  keys.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Kebord Null",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ))
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "${key.debugName}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          )),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text('Speed',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Center(
                                  child: Container(
                                width: 200,
                                child: SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 2500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 20000,
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                                value: speed.isNaN ? 0 : speed)
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                                widget: Container(
                                                    child: Text(
                                                        '${speed.round()}',
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                angle: 90,
                                                positionFactor: 0.5)
                                          ])
                                    ]),
                              )),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp1
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp1,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp1 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp2
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp2,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp2 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp3
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp3,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp3 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp4
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp4,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp4 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: width * .05),
                          Column(
                            children: [
                              const Text('acceleration',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Center(
                                  child: Container(
                                width: 200,
                                child: SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 2500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 20000900,
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                                value: acc.isNaN ? 0 : acc)
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                                widget: Container(
                                                    child: Text(
                                                        '${acc.round()}',
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                angle: 90,
                                                positionFactor: 0.5)
                                          ])
                                    ]),
                              )),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp5
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp5,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp5 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp6
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp6,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp6 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp7
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp7,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp7 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: height * .05,
                                          width: width * .025,
                                          decoration: BoxDecoration(
                                              color: lamp8
                                                  ? Colors.red
                                                  : Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      SizedBox(height: height * .1),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: [
                                              const AutoSizeText("ON"),
                                              Checkbox(
                                                  value: lamp8,
                                                  onChanged: (valu) {
                                                    setState(() {
                                                      lamp8 = valu!;
                                                    });
                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
