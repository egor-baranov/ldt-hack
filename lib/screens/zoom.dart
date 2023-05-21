import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Zoom extends StatelessWidget {
  const Zoom({super.key});

  Widget zoomCard(String text) {
    return Material(
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
      padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Text(
              "Консультации",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
            ),
            TextButton(onPressed: () {}, child: Text("Новая консультация")),
            SizedBox(height: 16),
            zoomCard("Консультация от 15.08 в 13:30"),
            SizedBox(height: 8),
            zoomCard("Консультация от 15.08 в 13:30"),
          ]),
    );
  }
}
