import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/consultation/Consultation.dart';
import 'call.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key, required this.consultationModel});

  final ConsultationModel consultationModel;

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  Widget consultationCard(String type, String? text) {
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
              Text(
                type,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                text ?? "—",
                style: GoogleFonts.inter(fontSize: 14),
              ),
            ],
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
              "Консультация",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Редактировать данные"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  consultationCard(
                    "Тема",
                    widget.consultationModel.title,
                  ),
                  SizedBox(height: 8),
                  consultationCard(
                    "Описание",
                    widget.consultationModel.description,
                  ),
                  SizedBox(height: 8),
                  consultationCard(
                    "Дата начала",
                    widget.consultationModel.day,
                  ),
                  SizedBox(height: 8),
                  consultationCard(
                    "Время начала",
                    widget.consultationModel.time,
                  ),
                  SizedBox(height: 32),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: CupertinoButton(
                      color: ColorResources.accentRed,
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Call(
                              consultationModel: widget.consultationModel,
                              channel: widget.consultationModel.id ?? "default",
                            ),
                          ),
                        );
                      },
                      child: Text("Подключиться"),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: CupertinoButton(
                      color: ColorResources.accentPink,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Отменить консультацию",
                        style: TextStyle(
                          color: ColorResources.accentRed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
