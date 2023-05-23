import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/screens/create_consultation.dart';

import '../models/Message.dart';
import '../styles/ColorResources.dart';
import 'consultation.dart';

class Zoom extends StatefulWidget {
  const Zoom({super.key});

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {

  Widget zoomCard(String title, String date, String time) {
    return Material(
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Consultation()),
        ),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$date в $time",
                      style:
                      const TextStyle(color: CupertinoColors.systemGrey, fontSize: 14),
                    ),

                    const Text(
                      "Есть запись",
                      style:
                      TextStyle(color: ColorResources.accentRed, fontSize: 14),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Консультации",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  IconButton(
                    iconSize: 28,
                    padding: EdgeInsets.zero,
                    color: CupertinoColors.darkBackgroundGray,
                    icon: const Icon(CupertinoIcons.calendar),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.parse("1900-01-01"),
                        lastDate: DateTime.parse("2300-12-31"),
                        initialDate: DateTime.now(),
                      );
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateConsultation()),
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
              SizedBox(height: 16),
              const Text(
                "Сегодня",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 16),
              const Text(
                "Вчера",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 16),
              const Text(
                "19 мая",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 16),
              const Text(
                "12 мая",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 8),
              zoomCard("Обсуждение нормативных актов и их влияния на бизнес", "24.03", "15:00"),
              SizedBox(height: 16),
            ]),
      ),
    );
  }
}
