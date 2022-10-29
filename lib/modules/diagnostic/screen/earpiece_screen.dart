import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:phonecheck/modules/diagnostic/widegt/dialogs.dart';
import 'package:tbibaudioplayers/tbibaudioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

typedef OnError = void Function(Exception exception);

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

class EarpieceScreen extends StatefulWidget {
  @override
  _EarpieceScreenState createState() => _EarpieceScreenState();
}

class _EarpieceScreenState extends State<EarpieceScreen> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;
  String localAudioCacheURI;

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.find<TestController>().onStartTest(12, 10);
    advancedPlayer.earpieceOrSpeakersToggle();
    advancedPlayer.setUrl(kUrl2);
    super.initState();
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
  }

  _play() {
    print('playyyyyy');
    advancedPlayer.setVolume(0.2);
    advancedPlayer.resume();
    Timer(Duration(seconds: 10), () {
      askResultDialog('Earpiece', 12);
      advancedPlayer.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EarPiece Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Btn(
                onPressed: () => _play(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Btn({Function onPressed}) {
  return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Play',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.play_arrow_rounded)
        ],
      ));
}
