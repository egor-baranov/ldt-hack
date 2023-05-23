import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/styles/ColorResources.dart';

class CreateConsultation extends StatefulWidget {
  const CreateConsultation({super.key});

  @override
  State<CreateConsultation> createState() => _CreateConsultationState();
}

class _CreateConsultationState extends State<CreateConsultation> {
  Widget textField(String label) {
    return TextField(
      cursorColor: Colors.black,
      onSubmitted: (String text) {},
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: CupertinoColors.extraLightBackgroundGray,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(10.0),
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
                  "Запись на консультацию",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                ),
                SizedBox(height: 8),
                const Text(
                  "Создайте консультацию с инспектором в удобное время, а перед ее началом вам придет уведомление",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                SizedBox(height: 32),
                textField("Тема"),
                SizedBox(height: 8),
                textField("Описание"),
                SizedBox(height: 8),
                textField("Дата начала"),
                SizedBox(height: 8),
                textField("Время начала"),
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
                      Navigator.pop(context);
                    },
                    child: Text("Записаться на консультацию"),
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
                    child: Text("Отменить создание записи"),
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
