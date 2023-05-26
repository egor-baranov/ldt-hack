import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';


class Register extends StatefulWidget {

  final Function onChangeFlow;

  const Register({super.key, required this.onChangeFlow});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              "Регистрация",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  const Text(
                    "Заполните данные для создания аккаунта, если вы — бизнес",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  SizedBox(height: 32),

                  Text(
                    "Контактные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  textField("Телефон"),
                  SizedBox(height: 8),
                  textField("Адрес электронной почты"),
                  SizedBox(height: 32),
                  //
                  Text(
                    "Основные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  textField("Фамилия"),
                  SizedBox(height: 8),
                  textField("Имя"),
                  SizedBox(height: 8),
                  textField("Отчество"),
                  SizedBox(height: 8),
                  textField("ИНН"),
                  SizedBox(height: 8),
                  textField("СНИЛС"),
                  SizedBox(height: 8),
                  textField("Пол"),
                  SizedBox(height: 8),
                  textField("Дата рождения"),
                  SizedBox(height: 8),
                  textField("Место рождения"),
                  SizedBox(height: 32),
                  //
                  Text(
                    "Паспортные данные",
                    style: GoogleFonts.ptSerif(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  textField("Серия"),
                  SizedBox(height: 8),
                  textField("Номер"),
                  SizedBox(height: 8),
                  textField("Дата выдачи"),
                  SizedBox(height: 8),
                  textField("Кем выдан"),
                  SizedBox(height: 8),
                  textField("Адрес регистрации"),
                  SizedBox(height: 32),
                  //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Уже есть аккаунт?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.onChangeFlow();
                          });
                        },
                        child: Text("Войти"),
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all(ColorResources.accentRed),
                          overlayColor: MaterialStateProperty.all(
                            ColorResources.accentRed.withOpacity(0.1),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: CupertinoButton(
                      color: ColorResources.accentRed,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      child: Text("Подтвердить и завершить"),
                    ),
                  ),
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