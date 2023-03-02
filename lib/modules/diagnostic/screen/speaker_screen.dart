// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart' as ja;
import 'package:flutter/material.dart';
import 'package:phonecheck/modules/core/constants/const.dart';
import 'package:phonecheck/modules/diagnostic/controller/test_controller.dart';
import 'package:tbibaudioplayers/tbibaudioplayers.dart';

import '../widegt/dialogs.dart';
import 'earpiece_screen.dart';

// class SpeakerScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => SpeakerScreenState();
// }

// class SpeakerScreenState extends State<SpeakerScreen> {
//   // AudioPlayer player = AudioPlayer();
//   // ja.AudioPlayer _player;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Get.find<TestController>().onStartTest(11, 15);

//   }

//   // initTest() {
//   //   _player = ja.AudioPlayer(
//   //     // Handle audio_session events ourselves for the purpose of this demo.
//   //     handleInterruptions: false,
//   //     androidApplyAudioAttributes: false,
//   //     handleAudioSessionActivation: false,
//   //   );
//   //   AudioSession.instance.then((audioSession) async {
//   //     // This line configures the app's audio session, indicating to the OS the
//   //     // type of audio we intend to play. Using the "speech" recipe rather than
//   //     // "music" since we are playing a podcast.
//   //     await audioSession.configure(AudioSessionConfiguration(
//   //       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//   //       avAudioSessionCategoryOptions:
//   //           AVAudioSessionCategoryOptions.allowBluetooth,
//   //       avAudioSessionMode: AVAudioSessionMode.voiceChat,
//   //       avAudioSessionRouteSharingPolicy:
//   //           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//   //       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//   //       androidAudioAttributes: const AndroidAudioAttributes(
//   //         contentType: AndroidAudioContentType.speech,
//   //         flags: AndroidAudioFlags.none,
//   //         usage: AndroidAudioUsage.voiceCommunication,
//   //       ),
//   //       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//   //       androidWillPauseWhenDucked: true,
//   //     ));

//   //     // Listen to audio interruptions and pause or duck as appropriate.
//   //     _handleInterruptions(audioSession);
//   //     await _player.setUrl(
//   //         "https://www.onlinemictest.com/wp-content/themes/onlinemictest/sound.mp3");
//   //   });
//   // }

//   // playAudio() {
//   //   initTest();
//   //   _player.play();
//   //   Timer(
//   //       Duration(seconds: 2),
//   //       () =>
//   //           askResultDialog("speaker", 11));
//   // }

//   // void _handleInterruptions(AudioSession audioSession) {
//   //   // just_audio can handle interruptions for us, but we have disabled that in
//   //   // order to demonstrate manual configuration.
//   //   bool playInterrupted = false;
//   //   audioSession.becomingNoisyEventStream.listen((_) {
//   //     print('PAUSE');
//   //     _player.pause();
//   //   });
//   //   _player.playingStream.listen((playing) {
//   //     playInterrupted = false;
//   //     if (playing) {
//   //       audioSession.setActive(true);
//   //     }
//   //   });
//   //   audioSession.interruptionEventStream.listen((event) {
//   //     print('interruption begin: ${event.begin}');
//   //     print('interruption type: ${event.type}');
//   //     if (event.begin) {
//   //       switch (event.type) {
//   //         case AudioInterruptionType.duck:
//   //           if (audioSession.androidAudioAttributes.usage ==
//   //               AndroidAudioUsage.game) {
//   //             _player.setVolume(_player.volume / 2);
//   //           }
//   //           playInterrupted = false;
//   //           break;
//   //         case AudioInterruptionType.pause:
//   //         case AudioInterruptionType.unknown:
//   //           if (_player.playing) {
//   //             _player.pause();
//   //             playInterrupted = true;
//   //           }
//   //           break;
//   //       }
//   //     } else {
//   //       switch (event.type) {
//   //         case AudioInterruptionType.duck:
//   //           // _player.setVolume(min(1.0, _player.volume * 2));
//   //           playInterrupted = false;
//   //           break;
//   //         case AudioInterruptionType.pause:
//   //           if (playInterrupted) _player.play();
//   //           playInterrupted = false;
//   //           break;
//   //         case AudioInterruptionType.unknown:
//   //           playInterrupted = false;
//   //           break;
//   //       }
//   //     }
//   //   });
//   //   audioSession.devicesChangedEventStream.listen((event) {
//   //     print('Devices added: ${event.devicesAdded}');
//   //     print('Devices removed: ${event.devicesRemoved}');
//   //   });
//   // }

//   // playSound() async{
//   //   String audioasset = "sounds/test.mp3";
//   //   await player.play(AssetSource(audioasset));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Center(
//                 child: StreamBuilder<ja.PlayerState>(
//                   stream: _player.playerStateStream,
//                   builder: (context, snapshot) {
//                     final playerState = snapshot.data;
//                     if (playerState?.processingState ==
//                         ja.ProcessingState.buffering) {
//                       return Container(
//                         margin: EdgeInsets.all(8.0),
//                         width: 64.0,
//                         height: 64.0,
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (playerState?.playing == true) {
//                       return IconButton(
//                         icon: Icon(Icons.pause),
//                         iconSize: 64.0,
//                         onPressed: _player.pause,
//                       );
//                     } else {
//                       return IconButton(
//                         icon: Icon(Icons.play_arrow),
//                         iconSize: 64.0,
//                         onPressed: playAudio,
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SpeakerScreen extends StatefulWidget {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  State<SpeakerScreen> createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  _play() {
    widget.audioPlayer.setVolume(0.2);
    widget.audioPlayer.resume();

    Timer(Duration(seconds: 15), () {
      askResultDialog(
        'Speaker',
        11,
      );
      widget.audioPlayer.stop();
    });
  }

  @override
  void initState() {
    Get.find<TestController>().onStartTest(11, 10);
    widget.audioPlayer.setUrl(
      kUrl2,
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
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
              Text(
                'Speaker Test',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () => _play(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Play',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.speaker)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
