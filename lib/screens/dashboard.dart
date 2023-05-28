import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:lodt_hack/screens/zoom.dart';
import 'package:lodt_hack/utils/calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/User.dart';
import '../models/consultation/Consultation.dart';
import '../models/consultation/ConsultationHolder.dart';
import '../providers/LocalStorageProvider.dart';
import '../styles/ColorResources.dart';
import '../utils/parser.dart';
import 'consultation.dart';
import 'info.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {super.key, required this.onSearch, required this.onOpenZoom});

  final Function onSearch;
  final Function onOpenZoom;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  ConsultationHolder consultations = ConsultationHolder([]);
  User user = User();
  String? token;

  void fetchData() {
    storageProvider.getConsultations().then(
          (value) => setState(
            () {
              consultations = value;
              print(consultations.toJson());
            },
          ),
        );
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
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
          fetchData(),
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

  int abs(int v) {
    if (v < 0) {
      return -v;
    }

    return v;
  }

  List<ConsultationModel> sorted(List<ConsultationModel> c) {
    c.sort((a, b) => abs(
            dateFromString(a.day!).toDateTime().day - DateTime.now().day)
        .compareTo(
            abs(dateFromString(b.day!).toDateTime().day - DateTime.now().day)));
    return c.toList();
  }

  Widget dashboardCard(
    String title,
    String description,
    String subtitle,
    String externalLink,
  ) {
    return Material(
      color: CupertinoColors.systemGrey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Info(
              title: title,
              description: description,
              externalLink: externalLink,
              subtitle: subtitle,
              buttonLabel: "Перейти на сайт",
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 320),
                      child: Text(
                        subtitle,
                        style: GoogleFonts.inter(fontSize: 16),
                        softWrap: true,
                        maxLines: 5,
                      ),
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
              "Главная",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
            trailing: Material(
              child: IconButton(
                onPressed: () {
                  widget.onSearch();
                },
                iconSize: 28,
                color: CupertinoColors.darkBackgroundGray,
                icon: const Icon(CupertinoIcons.search),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(height: 32),
                    ExpandablePanel(
                      header: Text(
                        "Календарь",
                        style: GoogleFonts.ptSerif(fontSize: 24),
                      ),
                      collapsed: Text(
                        "Расписание консультаций",
                        style: GoogleFonts.ptSerif(fontSize: 16),
                      ),
                      expanded: CalendarDatePicker2(
                        config: calendarConfig,
                        value: _singleDatePickerValueWithDefaultValue,
                        onValueChanged: (dates) => setState(
                          () => _singleDatePickerValueWithDefaultValue = dates,
                        ),
                      ),
                      theme: const ExpandableThemeData(
                          tapHeaderToExpand: true, hasIcon: true),
                    ),
                    SizedBox(height: 48),
                    ExpandablePanel(
                      header: Text(
                        "Ближайшие консультации",
                        style: GoogleFonts.ptSerif(fontSize: 24),
                      ),
                      collapsed: Text(
                        "Управляйте встречами прямо с главного экрана",
                        style: GoogleFonts.ptSerif(fontSize: 16),
                      ),
                      expanded: Column(
                        children: [
                          SizedBox(height: 16),
                          if (consultations.consultations.isEmpty)
                            Center(
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
                          ...sorted(consultations.consultations).take(5).map(
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
                          SizedBox(height: 8),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: CupertinoButton(
                              color: CupertinoColors.systemGrey5,
                              onPressed: () {
                                widget.onOpenZoom();
                              },
                              child: const Text(
                                "Все консультации",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      theme: const ExpandableThemeData(
                          tapHeaderToExpand: true, hasIcon: true),
                    ),
                    SizedBox(height: 48),
                    ExpandablePanel(
                      header: Text(
                        "Нормативные акты",
                        style: GoogleFonts.ptSerif(fontSize: 24),
                      ),
                      collapsed: Text(
                        "Подобранные на основании вашей активности",
                        style: GoogleFonts.ptSerif(fontSize: 16),
                      ),
                      expanded: Column(
                        children: [
                          SizedBox(height: 8),
                          dashboardCard(
                              "Нормативный акт",
                              'п. 1 ст. 20 Федерального закона от 22.11.1995 № 171-ФЗ "О государственном регулировании производства и оборота этилового спирта, алкогольной и спиртосодержащей продукции и об ограничении потребления (распития) алкогольной продукции": "Действие лицензии на производство и оборот этилового спирта, алкогольной и спиртосодержащей продукции приостанавливается решением лицензирующего органа на основании материалов, представленных органами, осуществляющими контроль и надзор за соблюдением настоящего Федерального закона, а также по инициативе самого лицензирующего органа в пределах его компетенции в следующих случаях: выявление нарушения, являющегося основанием для аннулирования лицензии".',
                              'Розничная продажа алкогольной продукции без маркировки, либо с маркировкой поддельными марками запрещена.',
                              'https://knd.mos.ru/requirements/public/8ff91444-9137-47d4-a463-92f400a33da9'),
                          SizedBox(height: 8),
                          dashboardCard(
                              "Нормативный акт",
                              'п. 1 ст. 20 Федерального закона от 22.11.1995 № 171-ФЗ "О государственном регулировании производства и оборота этилового спирта, алкогольной и спиртосодержащей продукции и об ограничении потребления (распития) алкогольной продукции": "Действие лицензии на производство и оборот этилового спирта, алкогольной и спиртосодержащей продукции приостанавливается решением лицензирующего органа на основании материалов, представленных органами, осуществляющими контроль и надзор за соблюдением настоящего Федерального закона, а также по инициативе самого лицензирующего органа в пределах его компетенции в следующих случаях: выявление нарушения, являющегося основанием для аннулирования лицензии".',
                              'Розничная продажа алкогольной продукции без маркировки, либо с маркировкой поддельными марками запрещена.',
                              'https://knd.mos.ru/requirements/public/8ff91444-9137-47d4-a463-92f400a33da9'),
                          SizedBox(height: 8),
                          dashboardCard(
                              "Нормативный акт",
                              'п. 1 ст. 20 Федерального закона от 22.11.1995 № 171-ФЗ "О государственном регулировании производства и оборота этилового спирта, алкогольной и спиртосодержащей продукции и об ограничении потребления (распития) алкогольной продукции": "Действие лицензии на производство и оборот этилового спирта, алкогольной и спиртосодержащей продукции приостанавливается решением лицензирующего органа на основании материалов, представленных органами, осуществляющими контроль и надзор за соблюдением настоящего Федерального закона, а также по инициативе самого лицензирующего органа в пределах его компетенции в следующих случаях: выявление нарушения, являющегося основанием для аннулирования лицензии".',
                              'Розничная продажа алкогольной продукции без маркировки, либо с маркировкой поддельными марками запрещена.',
                              'https://knd.mos.ru/requirements/public/8ff91444-9137-47d4-a463-92f400a33da9'),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: CupertinoButton(
                              color: CupertinoColors.systemGrey5,
                              onPressed: () {
                                launchUrl(Uri.parse(
                                    'https://knd.mos.ru/requirements/public#anchor_20a69a9e-3d06-41ec-956b-0f9f710ecddf'));
                              },
                              child: const Text(
                                "Все нормативные акты",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      theme: const ExpandableThemeData(
                          tapHeaderToExpand: true, hasIcon: true),
                    ),
                    SizedBox(height: 48),
                    ExpandablePanel(
                      header: Text(
                        "Органы контроля",
                        style: GoogleFonts.ptSerif(fontSize: 24),
                      ),
                      collapsed: Text(
                        "Наиболее релевантные для вас органы контроля",
                        style: GoogleFonts.ptSerif(fontSize: 16),
                      ),
                      expanded: Column(
                        children: [
                          SizedBox(height: 8),
                          dashboardCard(
                            "Орган контроля",
                            'Главное архивное управление города Москвы (Главархив) реализует государственную политику в сфере архивного дела, а также охраны и использования историко-документального наследия.',
                            'ГЛАВНОЕ АРХИВНОЕ УПРАВЛЕНИЕ ГОРОДА МОСКВЫ',
                            'https://knd.mos.ru/kno/details/bb1327a6-0a4f-40fa-a058-2a2f7c29980c?esc=%2Fkno',
                          ),
                          SizedBox(height: 8),
                          dashboardCard(
                            "Орган контроля",
                            'Государственная инспекция по контролю за использованием объектов недвижимости города Москвы (Госинспекция по недвижимости) осуществляет региональный государственный контроль за использованием объектов нежилого фонда на территории города Москвы и за ее пределами, находящихся в собственности города Москвы, в том числе являющихся объектами культурного наследия, мероприятия по определению вида фактического использования зданий (строений, сооружений) и нежилых помещений для целей налогообложения, контроль за соблюдением требований к размещению сезонных (летних) кафе при стационарных предприятиях общественного питания, муниципальный земельный контроль за использованием земель на территории города Москвы, выполняет полномочия собственника в части осуществления мероприятий по контролю за использованием земель, находящихся в собственности города Москвы и государственная собственность на которые не разграничена, и объектов нежилого фонда, а также организации их охраны в целях предотвращения и пресечения самовольного занятия и незаконного использования.',
                            'ГОСУДАРСТВЕННАЯ ИНСПЕКЦИЯ ПО КОНТРОЛЮ ЗА ИСПОЛЬЗОВАНИЕМ ОБЪЕКТОВ НЕДВИЖИМОСТИ ГОРОДА МОСКВЫ',
                            'https://knd.mos.ru/kno/details/b3310d09-5c67-4eaf-8eeb-4c011ad60f98?esc=%2Fkno',
                          ),
                          SizedBox(height: 8),
                          dashboardCard(
                            "Орган контроля",
                            'Департамент здравоохранения города Москвы реализует государственную политику в сфере здравоохранения и создаёт необходимые условия для оказания медицинской помощи. Также занимается программами обеспечения лекарственными препаратами, предоставляет услуги по лицензированию в сфере здравоохранения.',
                            'ДЕПАРТАМЕНТ ЗДРАВООХРАНЕНИЯ ГОРОДА МОСКВЫ',
                            'https://knd.mos.ru/requirements/public/8ff91444-9137-47d4-a463-92f400a33da9',
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: CupertinoButton(
                              color: CupertinoColors.systemGrey5,
                              onPressed: () {
                                launchUrl(Uri.parse('https://knd.mos.ru/kno'));
                              },
                              child: const Text(
                                "Все органы контроля",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      theme: const ExpandableThemeData(
                          tapHeaderToExpand: true, hasIcon: true),
                    ),
                    SizedBox(height: 48),
                    ExpandablePanel(
                      header: Text(
                        "Обязательные требования",
                        style: GoogleFonts.ptSerif(fontSize: 24),
                      ),
                      collapsed: Text(
                        "Исходя из вашей истории запросов",
                        style: GoogleFonts.ptSerif(fontSize: 16),
                      ),
                      expanded: Column(
                        children: [
                          SizedBox(height: 8),
                          dashboardCard(
                              "Обязательное требование",
                              'п. 1 ст. 20 Федерального закона от 22.11.1995 № 171-ФЗ "О государственном регулировании производства и оборота этилового спирта, алкогольной и спиртосодержащей продукции и об ограничении потребления (распития) алкогольной продукции": "Действие лицензии на производство и оборот этилового спирта, алкогольной и спиртосодержащей продукции приостанавливается решением лицензирующего органа на основании материалов, представленных органами, осуществляющими контроль и надзор за соблюдением настоящего Федерального закона, а также по инициативе самого лицензирующего органа в пределах его компетенции в следующих случаях: выявление нарушения, являющегося основанием для аннулирования лицензии".',
                              'Розничная продажа алкогольной продукции без маркировки, либо с маркировкой поддельными марками запрещена.',
                              'https://knd.mos.ru/requirements/public/8ff91444-9137-47d4-a463-92f400a33da9'),
                          SizedBox(height: 8),
                          dashboardCard(
                            "Обязательное требование",
                            'ч. 1 ст. 8.20 Закона г. Москвы от 21.11.2007 № 45 "Кодекс города Москвы об административных правонарушениях": "Нарушение правил содержания и эксплуатации автомобильных дорог (объектов улично-дорожной сети) и технических средств их обустройства - влечет предупреждение или наложение административного штрафа на граждан в размере от одной тысячи пятисот до двух тысяч рублей; на должностных лиц - от пяти тысяч до десяти тысяч рублей; на юридических лиц - от тридцати тысяч до пятидесяти тысяч рублей".',
                            'Соблюдение требований к содержанию объектов дорожного хозяйства в зимний период в соответствии с Постановлением Правительства Москвы №762',
                            'https://knd.mos.ru/requirements/public/d7841855-3052-479b-801f-0e8e812fb901',
                          ),
                          SizedBox(height: 8),
                          dashboardCard(
                            "Обязательное требование",
                            'ч. 1 ст. 8.18 Закона г. Москвы от 21.11.2007 № 45 "Кодекс города Москвы об административных правонарушениях": "Нарушение установленных Правительством Москвы правил производства земляных работ и работ по организации площадок для проведения отдельных работ в сфере благоустройства, в том числе отсутствие утвержденной проектной документации или необходимых согласований при проведении указанных работ, несвоевременное восстановление благоустройства территории после их завершения, непринятие мер по ликвидации провала асфальта (грунта), связанного с производством разрытий, а также несоблюдение установленных требований к обустройству и содержанию строительных площадок - влечет предупреждение или наложение административного штрафа на граждан в размере от трех тысяч до пяти тысяч рублей; на должностных лиц - от двадцати тысяч до тридцати пяти тысяч рублей; на юридических лиц - от трехсот тысяч до пятисот тысяч рублей".',
                            'Требование к аварийному освещению и освещению опасных мест.',
                            'https://knd.mos.ru/requirements/public/20a69a9e-3d06-41ec-956b-0f9f710ecddf',
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color: CupertinoColors.systemGrey5,
                              onPressed: () {
                                launchUrl(Uri.parse(
                                    'https://knd.mos.ru/requirements/public#anchor_20a69a9e-3d06-41ec-956b-0f9f710ecddf'));
                              },
                              child: const Text(
                                "Все обязательные требования",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      theme: const ExpandableThemeData(
                          tapHeaderToExpand: true, hasIcon: true),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
