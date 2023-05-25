import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/ColorResources.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.onSearch});

  final Function onSearch;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Widget dashboardCard(String text) {
      return Material(
        color: CupertinoColors.systemGrey6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: [
              Container(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Главная",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.onSearch();
                    },
                    iconSize: 28,
                    color: CupertinoColors.darkBackgroundGray,
                    icon: const Icon(CupertinoIcons.search),
                  ),
                ],
              ),
              TextButton(
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
                child: Text("Открыть календарь"),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(ColorResources.accentRed),
                  overlayColor: MaterialStateProperty.all(
                    ColorResources.accentRed.withOpacity(0.1),
                  ),
                ),
              ),
              Container(height: 32),
              const Text(
                "Календарь",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              CalendarDatePicker(
                firstDate: DateTime.parse("1900-01-01"),
                lastDate: DateTime.parse("2300-12-31"),
                initialDate: DateTime.now(),
                onDateChanged: (DateTime dateTime) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ближайшие консультации",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text("Развернуть"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              dashboardCard("Текст встречи"),
              SizedBox(height: 8),
              dashboardCard("Текст встречи"),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Органы контроля",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text("Развернуть"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              dashboardCard("Орган контроля"),
              SizedBox(height: 8),
              dashboardCard("Орган контроля"),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Нормативные акты",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Развернуть"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              dashboardCard("Нормативный акт"),
              SizedBox(height: 8),
              dashboardCard("Нормативный акт"),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Обязательные требования",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text("Развернуть"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              dashboardCard("Обязательное требование"),
              SizedBox(height: 8),
              dashboardCard("Обязательное требование"),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FAQ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text("Развернуть"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              dashboardCard("Вопрос в FAQ"),
              SizedBox(height: 8),
              dashboardCard("Вопрос в FAQ"),
              SizedBox(height: 16),
            ]),
      ),
    );
  }
}
