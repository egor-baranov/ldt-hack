import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lodt_hack/providers/LocalStorageProvider.dart';
import 'package:lodt_hack/screens/account/edit_account.dart';
import 'package:lodt_hack/utils/parser.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../models/User.dart';
import '../../styles/ColorResources.dart';
import '../auth/login.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  User? user;

  void fetchData() {
    storageProvider.getUser().then(
          (value) => setState(
            () {
              user = value;
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Widget accountCard(String type, String? text) {
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
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  isBlank(text) ? "—" : text!,
                  style: GoogleFonts.inter(fontSize: 14),
                ),
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
              "Профиль",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
            trailing: Material(
              child: IconButton(
                icon: const Icon(CupertinoIcons.settings_solid),
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => Scaffold(
                      persistentFooterAlignment: AlignmentDirectional.center,
                      body: Container(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16),
                                  Text(
                                    "Настройки",
                                    style: GoogleFonts.ptSerif(fontSize: 32),
                                  ),
                                  SizedBox(height: 160),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: CupertinoButton(
                                      color: ColorResources.accentRed,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => Login(
                                              onChangeFlow: () {},
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text("Выйти из аккаунта"),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: CupertinoButton(
                                      color: ColorResources.accentRed,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => Login(
                                              onChangeFlow: () {},
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text("Удалить аккаунт"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 12,
                              child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  borderRadius: BorderRadius.circular(64),
                                  color: CupertinoColors.systemGrey5,
                                  onPressed: () =>
                                      Navigator.of(context).popUntil(
                                    (route) => route.settings.name == '/',
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: CupertinoColors.darkBackgroundGray,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => EditAccount(initialUser: user!),
                        ),
                      ).then((value) => fetchData());
                    },
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
                  accountCard("Название бизнеса", user?.businessName),
                  SizedBox(height: 16),
                  accountCard(
                      "Род деятельности", user?.userType ?? "Предприниматель"),
                  SizedBox(height: 32),
                  Text(
                    "Контактные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  accountCard("Телефон", user?.phone),
                  SizedBox(height: 8),
                  accountCard("Адрес электронной почты", user?.email),
                  SizedBox(height: 32),
                  Text(
                    "Основные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  accountCard("Фамилия", user?.lastName),
                  SizedBox(height: 8),
                  accountCard("Имя", user?.firstName),
                  SizedBox(height: 8),
                  accountCard("Отчество", user?.patronymic),
                  SizedBox(height: 8),
                  accountCard("ИНН", user?.inn),
                  SizedBox(height: 8),
                  accountCard("СНИЛС", user?.snils),
                  SizedBox(height: 8),
                  accountCard("Пол", user?.sex),
                  SizedBox(height: 8),
                  accountCard("Дата рождения", user?.birthDate),
                  SizedBox(height: 8),
                  accountCard("Место рождения", user?.birthPlace),
                  SizedBox(height: 32),
                  Text(
                    "Паспортные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  accountCard("Серия", user?.passport?.series),
                  SizedBox(height: 8),
                  accountCard("Номер", user?.passport?.number),
                  SizedBox(height: 8),
                  accountCard("Дата выдачи", user?.passport?.date),
                  SizedBox(height: 8),
                  accountCard("Кем выдан", user?.passport?.place),
                  SizedBox(height: 8),
                  accountCard(
                      "Адрес регистрации", user?.passport?.registration),
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
