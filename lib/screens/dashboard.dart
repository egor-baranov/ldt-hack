import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:lodt_hack/utils/calendar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/ColorResources.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.onSearch});

  final Function onSearch;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

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

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              "Главная",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
            trailing: IconButton(
              onPressed: () {
                widget.onSearch();
              },
              iconSize: 28,
              color: CupertinoColors.darkBackgroundGray,
              icon: const Icon(CupertinoIcons.search),
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
                    Text(
                      "Календарь",
                      style: GoogleFonts.ptSerif(fontSize: 24),
                    ),
                    CalendarDatePicker2(
                      config: calendarConfig,
                      value: _singleDatePickerValueWithDefaultValue,
                      onValueChanged: (dates) => setState(
                            () => _singleDatePickerValueWithDefaultValue = dates,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ближайшие консультации",
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.expand_more_rounded, size: 24),
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
                        Text(
                          "Органы контроля",
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.expand_more_rounded, size: 24),
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
                        Text(
                          "Нормативные акты",
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.expand_more_rounded, size: 24),
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
                        Text(
                          "Обязательные требования",
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.expand_more_rounded, size: 24),
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
                        Text(
                          "FAQ",
                          style: GoogleFonts.ptSerif(fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.expand_more_rounded, size: 24),
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
          ),
        ],
      ),
    );
  }
}
