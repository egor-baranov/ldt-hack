import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lodt_hack/models/consultation/Consultation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agora_uikit/agora_uikit.dart';

class Call extends StatefulWidget {
  const Call({super.key, required this.consultationModel});

  final ConsultationModel consultationModel;

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int? _remoteUid;
  bool _localUserJoined = false;

  late RtcEngine _engine;

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      username: "user" + Random.secure().nextInt(1000).toString(),
      appId: "faa5e42e20664f2e8090edd45ae9b1a6",
      channelName: "test",
      tempToken: "007eJxTYCjcJSPG+XrL3DuJcdutN3E+neHUL6C6eWaJ88x5K7QT79srMKQlJpqmmhilGhmYmZmkGaVaGFgapKakmJgmplomGSaa1aUUpDQEMjJM1YlgZmSAQBCfhaEktbiEgQEAGOMelA==",
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await client.initialize();

    await [Permission.microphone, Permission.camera].request();

    const appId = "984cb29f782444e08e63021f98a49719";
    const token = "38510c39230a4bdd92d5d0ac776a032d";
    const channel = "1";

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
      channelId: channel,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Text(
                "Консультация с инспектором",
                style: GoogleFonts.ptSerif(fontSize: 32),
              ),
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
                addScreenSharing: false,
                enabledButtons: [
                  BuiltInButtons.toggleMic,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleCamera,
                ],// Add this to enable screen sharing
              ),
            ],
          ),
        ),
      ),
    );
  }
}
