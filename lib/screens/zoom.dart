import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/clients/ApiClient.dart';
import 'package:lodt_hack/models/consultation/Consultation.dart';
import 'package:lodt_hack/models/consultation/ConsultationHolder.dart';
import 'package:lodt_hack/providers/LocalStorageProvider.dart';
import 'package:lodt_hack/screens/create_consultation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/google/protobuf/empty.pb.dart';
import '../models/User.dart';
import '../styles/ColorResources.dart';
import '../utils/parser.dart';
import 'consultation.dart';
import 'package:grpc/grpc.dart';

class Zoom extends StatefulWidget {
  const Zoom({super.key});

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  List<ConsultationModel> consultations = [];
  User user = User();
  String? token;
  Timer? timer;

  void fetchData() {
    storageProvider.getUser().then(
          (value) => setState(
            () {
              user = value!;
            },
          ),
        );
    storageProvider.getToken().then(
          (value) => setState(
            () {
              token = value!;
              fetchConsultations();
            },
          ),
        );

    fetchConsultations();
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => fetchConsultations());
  }

  Future<void> fetchConsultations() async {
    if (token == null || !mounted) {
      return;
    }

    print("Fetching consultations..." + Random(100).nextInt(100).toString());

    try {
      final response = await apiClient.listConsultationAppointments(
        Empty(),
        options: CallOptions(
          metadata: {'Authorization': 'Bearer ${token!}'},
        ),
      );

      setState(() {
        consultations = response.appointmentInfo
            .map(
              (e) => ConsultationModel(
                id: e.id,
                title: e.topic,
                description:
                    "Предприниматель: ${e.businessUser.firstName} ${e.businessUser.lastName}\nИнспектор: ${e.authorityUser.firstName} ${e.authorityUser.lastName}",
                day: stringFromTimestamp(e.fromTime),
                time: formatTime(e.fromTime),
              ),
            )
            .toList();
      });
    } on GrpcError catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка получения данных"),
            content: Text(e.message ?? "Текст ошибки отсутствует"),
            actions: [
              TextButton(
                child: Text("Продолжить"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  List<ConsultationModel> sorted(List<ConsultationModel> c) {
    c.sort((a, b) => dateFromString(a.day!)
        .toDateTime()
        .compareTo(dateFromString(b.day!).toDateTime()));
    return c.reversed.toList();
  }

  Widget zoomCard(ConsultationModel consultation) {
    return Material(
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () => {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Consultation(
                consultationModel: consultation,
              ),
            ),
          ),
          setState(() {
            fetchData();
          })
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(consultation.title!),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${formatDate(consultation.day!)} в ${consultation.time}",
                      style: const TextStyle(
                          color: CupertinoColors.systemGrey, fontSize: 14),
                    ),
                    Text(
                      consultation.tags == null || consultation.tags!.isEmpty
                          ? ""
                          : consultation.tags![0],
                      style: const TextStyle(
                          color: ColorResources.accentRed, fontSize: 14),
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              "Консультации",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
            trailing: Material(
              child: IconButton(
                icon: const Icon(CupertinoIcons.calendar),
                onPressed: () {
                  showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ColorResources.accentRed,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: ColorResources.accentRed,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    firstDate: DateTime.parse("1900-01-01"),
                    lastDate: DateTime.parse("2300-12-31"),
                    initialDate: DateTime.now(),
                  );
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  if (user.isBusiness())
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CreateConsultation(),
                          ),
                        );

                        setState(
                          () {
                            Future.delayed(const Duration(seconds: 3),
                                () {
                              fetchConsultations();
                            });
                          },
                        );
                      },
                      child: Text("Записаться на консультацию"),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(ColorResources.accentRed),
                        overlayColor: MaterialStateProperty.all(
                          ColorResources.accentRed.withOpacity(0.1),
                        ),
                      ),
                    ),
                  if (user.isBusiness()) SizedBox(height: 16),
                  if (consultations.isEmpty)
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 300),
                          child: Text(
                            user.isBusiness()
                                ? "Вы пока не записались ни на одну консультацию"
                                : "В данный момент вы не записаны в качестве инспектора на какую-либо консультацию",
                            softWrap: true,
                            maxLines: 3,
                            style: GoogleFonts.ptSerif(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ...sorted(consultations).map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDate(e.day!),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        SizedBox(height: 4),
                        zoomCard(e),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
