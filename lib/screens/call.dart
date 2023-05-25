import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:permission_handler/permission_handler.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int? _remoteUid;
  bool _localUserJoined = false;

  bool _camEnabled = false;
  bool _micEnabled = false;

  // late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    // initAgora();
  }

  // Future<void> initAgora() async {
  //   await [Permission.microphone, Permission.camera].request();
  //
  //   const appId = "984cb29f782444e08e63021f98a49719";
  //   const token = "";
  //   const channel = "";
  //
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
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                    color: CupertinoColors.systemGrey, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w800),
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
          padding: const EdgeInsets.all(32),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                const Text(
                  "Консультация с инспектором",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 16),
                const Text(
                  "Мерзляков Василий Викторович",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  // child: _localUserJoined
                  //     ? AgoraVideoView(
                  //         controller: VideoViewController(
                  //           rtcEngine: _engine,
                  //           canvas: const VideoCanvas(uid: 0),
                  //         ),
                  //       )
                  //     : const CircularProgressIndicator(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            ColorResources.accentRed,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(24)),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      child: const Icon(Icons.chat_rounded,
                          color: Colors.white, size: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _micEnabled = !_micEnabled;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _micEnabled
                                ? ColorResources.accentRed
                                : ColorResources.darkGrey,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(24)),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      child: const Icon(Icons.keyboard_voice,
                          color: Colors.white, size: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            ColorResources.accentRed,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(24)),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      child: const Icon(Icons.call_end_rounded,
                          color: Colors.white, size: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _camEnabled = !_camEnabled;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _camEnabled
                                ? ColorResources.accentRed
                                : ColorResources.darkGrey,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(24)),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      child: Icon(
                        _camEnabled
                            ? Icons.videocam_rounded
                            : Icons.videocam_off_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            ColorResources.accentRed,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(24)),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
                      child: const Icon(Icons.more_horiz_rounded,
                          color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
