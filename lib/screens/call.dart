import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lodt_hack/models/consultation/Consultation.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class Call extends StatefulWidget {
  const Call(
      {super.key, required this.consultationModel, required this.channel});

  final ConsultationModel consultationModel;
  final String channel;

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int? _remoteUid;
  bool _localUserJoined = false;

  late RtcEngine _engine;

  bool muted = false;

  String baseUrl = ''; //Add the link of your deployed server

  // var required for recording the call
  bool recording = false;
  int uid = 0;
  String rid = "";
  String sid = "";
  int recUid = 0;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    // clear users
    _remoteUid = null;
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    // destroy sdk
    await _engine.leaveChannel();
    await _engine.release();
  }


  Future<void> initAgora() async {

    await [Permission.microphone, Permission.camera].request();

    const appId = "faa5e42e20664f2e8090edd45ae9b1a6";
    const token = "007eJxTYLj7IL7xJs8lLr11e2+eq25z/8i8cjb7L5d/ux8uXR47d2aGAkNaYqJpqolRqpGBmZlJmlGqhYGlQWpKiolpYqplkmGiWV9SfUpDICNDlPU6VkYGCATxWRhKUotLGBgALukiKA==";
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: "test", // widget.channel
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

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

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Container(
        padding: EdgeInsets.only(bottom: 32),
        width: 400,
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: "test"),
          ),
        ),
      );
    } else {
      return Text(
        'Пользователь еще не подключился',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() async {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onToggleRecording() async {
    setState(() {
      recording = !recording;
    });
    if (recording) {
      await _startRecording(widget.channel);
    } else {
      await _stopRecording(widget.channel, rid, sid, recUid);
    }
  }

  void _onSwitchCamera() async {
    _engine.switchCamera();
  }

  Widget buildButtons() {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints(maxWidth: 50),
            onPressed: showChat,
            child: Icon(
              CupertinoIcons.chat_bubble_text,
              color: ColorResources.accentRed,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            constraints: BoxConstraints(maxWidth: 50),
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : ColorResources.accentRed,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? ColorResources.accentRed : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            constraints: BoxConstraints(maxWidth: 50),
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            constraints: BoxConstraints(maxWidth: 50),
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: ColorResources.accentRed,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            constraints: BoxConstraints(maxWidth: 50),
            onPressed: _onToggleRecording,
            child: recording
                ? Icon(
                    Icons.radio_button_checked_outlined,
                    color: ColorResources.accentRed,
                    size: 20.0,
                  )
                : Icon(
                    Icons.radio_button_unchecked_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }

  void showChat() {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        persistentFooterAlignment: AlignmentDirectional.center,
        body: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      "Чат",
                      style: GoogleFonts.ptSerif(fontSize: 32),
                    ),
                    const SizedBox(height: 32),

                    const SizedBox(height: 32),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: CupertinoButton(
                        color: ColorResources.accentRed,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Применить",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    borderRadius: BorderRadius.circular(64),
                    color: CupertinoColors.systemGrey5,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                  ),
                ),
              )
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
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _localUserJoined
                        ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
              buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _stopRecording(
      String mChannelName, String mRid, String mSid, int mRecUid) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/api/stop/call'),
      body: {
        "channel": mChannelName,
        "rid": mRid,
        "sid": mSid,
        "uid": mRecUid.toString()
      },
    );

    if (response.statusCode == 200) {
      print('Recording Ended');
    } else {
      print('Couldn\'t end the recording : ${response.statusCode}');
    }
  }

  Future<void> _startRecording(String channelName) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/api/start/call'),
      body: {"channel": channelName},
    );

    if (response.statusCode == 200) {
      print('Recording Started');
      setState(() {
        rid = jsonDecode(response.body)['data']['rid'];
        recUid = jsonDecode(response.body)['data']['uid'];
        sid = jsonDecode(response.body)['data']['sid'];
      });
    } else {
      print('Couldn\'t start the recording : ${response.statusCode}');
    }
  }
}
