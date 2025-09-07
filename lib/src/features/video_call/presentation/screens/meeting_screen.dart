import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage(
      {super.key,
      required this.scheduleId,
      required this.userName,
      required this.userId});

  final String scheduleId;
  final String userName;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        userName: userName,
        appID: int.parse(CallInfo.appId),
        appSign: CallInfo.appSign,
        callID: scheduleId,
        userID: userId,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        // ..audioConfig = ZegoAudioConfig(
        //   enableAEC: true,  // Enable echo cancellation
        //   enableAGC: true,  // Automatic gain control
        //   enableNS: true,   // Noise suppression
        // ),
        // config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        );
  }
}

class CallInfo {
  static String appId = dotenv.env['ZEGO_APP_ID']!;
  static String appSign = dotenv.env['ZEGO_APP_SIGN']!;
}
