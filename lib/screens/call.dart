import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int? _remoteUid;
  bool _localUserJoined = false;
  // late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    // initAgora();
  }

  // Future<void> initAgora() async {
  //   // retrieve permissions
  //   await [Permission.microphone, Permission.camera].request();
  //
  //   const appId = "";
  //   const token = "";
  //   const channel = "";
  //
  //   //create the engine
  //   _engine = createAgoraRtcEngine();
  //   await _engine.initialize(const RtcEngineContext(
  //     appId: appId,
  //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //   ));
  //
  //   _engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         debugPrint("local user ${connection.localUid} joined");
  //         setState(() {
  //           _localUserJoined = true;
  //         });
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         debugPrint("remote user $remoteUid joined");
  //         setState(() {
  //           _remoteUid = remoteUid;
  //         });
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         debugPrint("remote user $remoteUid left channel");
  //         setState(() {
  //           _remoteUid = null;
  //         });
  //       },
  //       onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
  //         debugPrint(
  //             '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
  //       },
  //     ),
  //   );
  //
  //   await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  //   await _engine.enableVideo();
  //   await _engine.startPreview();
  //
  //   await _engine.joinChannel(
  //     token: token,
  //     channelId: channel,
  //     uid: 0,
  //     options: const ChannelMediaOptions(),
  //   );
  // }

  Widget consultationCard(String type, String text) {
    return Material(
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type,
                  style: TextStyle(
                      color: CupertinoColors.systemGrey, fontSize: 14)),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                // SizedBox(
                //   width: 100,
                //   height: 150,
                //   child: Center(
                //     child: _localUserJoined
                //         ? AgoraVideoView(
                //             controller: VideoViewController(
                //               rtcEngine: _engine,
                //               canvas: const VideoCanvas(uid: 0),
                //             ),
                //           )
                //         : const CircularProgressIndicator(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
