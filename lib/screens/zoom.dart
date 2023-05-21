import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Message.dart';

class Zoom extends StatefulWidget {
  const Zoom({super.key});

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {

  Widget zoomCard(String text) {
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
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
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
                  onPressed: () {}, child: Text("Записаться на консультацию")),
              SizedBox(height: 16),
              const Text(
                "Сегодня",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Консультация в 13:30"),
              SizedBox(height: 8),
              zoomCard("Консультация в 15:45"),
              SizedBox(height: 16),
              const Text(
                "Вчера",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Консультация в 13:30"),
              SizedBox(height: 8),
              zoomCard("Консультация в 15:45"),
              SizedBox(height: 16),
              const Text(
                "19 мая",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Консультация в 13:30"),
              SizedBox(height: 8),
              zoomCard("Консультация в 15:45"),
              SizedBox(height: 16),
              const Text(
                "12 мая",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 8),
              zoomCard("Консультация в 13:30"),
              SizedBox(height: 8),
              zoomCard("Консультация в 15:45"),
              SizedBox(height: 16),
            ]),
      ),
    );
  }
}
