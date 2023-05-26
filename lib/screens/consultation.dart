import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

import 'call.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
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
              Text(
                type,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                text,
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
                SizedBox(height: 16),
                Text(
                  "Консультация",
                  style: GoogleFonts.ptSerif(fontSize: 32),
                ),
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
                consultationCard("Тема",
                    "Обсуждение нормативных актов и их влияния на бизнес"),
                SizedBox(height: 8),
                consultationCard("Описание",
                    "Требуется обсудить перечень нормативных актов"),
                SizedBox(height: 8),
                consultationCard("Дата начала", "22.05.2023"),
                SizedBox(height: 8),
                consultationCard("Время начала", "13:30"),
                SizedBox(height: 32),
                Container(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Call()),
                      );
                    },
                    child: Text("Подключиться к консультации"),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorResources.accentPink),
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Отменить консультацию"),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
