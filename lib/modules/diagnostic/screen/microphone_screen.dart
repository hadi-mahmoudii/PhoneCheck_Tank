import 'package:get/get.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:phonecheck/modules/core/constants/const.dart';

import '../controller/test_controller.dart';

class MicrophoneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MicrophoneScreenState();
}

class MicrophoneScreenState extends State<MicrophoneScreen> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  String noiseDecibel = "0";
  bool isFinish = false;

  @override
  void initState() {
    super.initState();
    Get.find<TestController>().onStartTest(13, 15);
    _noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!_isRecording) {
        _isRecording = true;
      }
    });
    print(noiseReading.toString());
    if (noiseReading.meanDecibel > 50.0) {
        Get.find<TestController>().onEndTest(13, "pass" );

      stop();

    }
    setState(() {
      noiseDecibel = noiseReading.meanDecibel.toString();
    });
  }

  void onError(Object error) {
    print(error.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      setState(() {
        _isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.all(25),
              child: Column(children: [
                Text(noiseDecibel,
                    style: TextStyle(fontSize: 25, color: Colors.blue)),
                GestureDetector(
                  onTap: _isRecording ? stop : start,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                        color: _isRecording ? Colors.green : Colors.red,
                        boxShadow: [defaultShadow],
                        borderRadius: BorderRadius.circular(cardRadius)),
                    child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    margin: EdgeInsets.only(top: 20),
                  ),
                )
              ])),
        ])),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: _isRecording ? Colors.red : Colors.green,
        //     onPressed: _isRecording ? stop : start,
        //     child: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
      ),
    );
  }
}
