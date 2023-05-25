import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/screens/forgot_email.dart';
import 'package:lodt_hack/styles/ColorResources.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool useLogin = true;
  bool isBusiness = true;

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

  Widget login() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: [
        SizedBox(height: 16),
        const Text(
          "Вход в личный кабинет",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
        ),
        SizedBox(height: 8),
        const Text(
          "Для входа в личный кабинет выберите полномочие и авторизуйтесь",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(isBusiness
                          ? ColorResources.accentRed
                          : CupertinoColors.secondarySystemFill),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isBusiness = true;
                      });
                    },
                    child: const Text(
                      "Бизнес",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(isBusiness
                          ? CupertinoColors.secondarySystemFill
                          : ColorResources.accentRed),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isBusiness = false;
                      });
                    },
                    child: const Text(
                      "Орган контроля",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 32),
        textField("Адрес электронной почты"),
        SizedBox(height: 8),
        textField("Пароль"),
        Spacer(),
        isBusiness ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Нет аккаунта?"),
            TextButton(
              onPressed: () {
                setState(() {
                  useLogin = false;
                });
              },
              child: Text("Создать"),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(ColorResources.accentRed),
                overlayColor: MaterialStateProperty.all(
                  ColorResources.accentRed.withOpacity(0.1),
                ),
              ),
            )
          ],
        ) : SizedBox(),
        isBusiness ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Забыли пароль?"),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotEmail()),
                );
              },
              child: Text("Восстановить"),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(ColorResources.accentRed),
                overlayColor: MaterialStateProperty.all(
                  ColorResources.accentRed.withOpacity(0.1),
                ),
              ),
            )
          ],
        ) : SizedBox(),
        SizedBox(height: 8),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Text("Войти"),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget register() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(height: 16),
          const Text(
            "Регистрация",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
          ),
          SizedBox(height: 8),
          const Text(
            "Заполните данные для создания аккаунта, если вы — бизнес",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          ),
          SizedBox(height: 32),

          const Text(
            "Контактные данные",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          SizedBox(height: 8),
          textField("Телефон"),
          SizedBox(height: 8),
          textField("Адрес электронной почты"),
          SizedBox(height: 32),
          //
          const Text(
            "Основные данные",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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
          const Text(
            "Паспортные данные",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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
                    useLogin = true;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: useLogin ? login() : register(),
        ),
      ),
    );
  }
}
