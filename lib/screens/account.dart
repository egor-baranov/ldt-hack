import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/ColorResources.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    Widget accountCard(String type, String text) {
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
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: [
              SizedBox(height: 16),
              Text(
                "Профиль",
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
              accountCard("Род деятельности", "Предприниматель"),
              SizedBox(height: 32),
              Text(
                "Контактные данные",
                style: GoogleFonts.ptSerif(fontSize: 24),
              ),
              SizedBox(height: 8),
              accountCard("Телефон", "+79776661234"),
              SizedBox(height: 8),
              accountCard("Адрес электронной почты", "hello@yandex.ru"),
              SizedBox(height: 32),
              Text(
                "Основные данные",
                style: GoogleFonts.ptSerif(fontSize: 24),
              ),
              SizedBox(height: 8),
              accountCard("Фамилия", "Антонов"),
              SizedBox(height: 8),
              accountCard("Имя", "Алексей"),
              SizedBox(height: 8),
              accountCard("Отчество", "Сергеевич"),
              SizedBox(height: 8),
              accountCard("ИНН", "7743013902"),
              SizedBox(height: 8),
              accountCard("СНИЛС", "20017148898"),
              SizedBox(height: 8),
              accountCard("Пол", "Мужской"),
              SizedBox(height: 8),
              accountCard("Дата рождения", "31.08.1986"),
              SizedBox(height: 8),
              accountCard("Место рождения", "г. Москва"),
              SizedBox(height: 32),
              Text(
                "Паспортные данные",
                style: GoogleFonts.ptSerif(fontSize: 24),
              ),
              SizedBox(height: 8),
              accountCard("Серия", "4321"),
              SizedBox(height: 8),
              accountCard("Номер", "564321"),
              SizedBox(height: 8),
              accountCard("Дата выдачи", "31.12.2016"),
              SizedBox(height: 8),
              accountCard("Кем выдан", "МВД ПО САНКТ-ПЕТЕРБУРГУ"),
              SizedBox(height: 8),
              accountCard("Адрес регистрации", "г. Санкт-Петербург"),
              SizedBox(height: 16),
            ]),
      ),
    );
  }
}
