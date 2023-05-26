import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/client/ApiClient.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/screens/forgot_email.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/app.pbgrpc.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            SizedBox(height: 16),
            Text(
              "Вход в личный кабинет",
              style: GoogleFonts.ptSerif(fontSize: 32),
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
                CupertinoButton(
                  color: isBusiness
                      ? ColorResources.accentRed
                      : CupertinoColors.secondarySystemFill,
                  onPressed: () {
                    setState(() {
                      isBusiness = true;
                    });
                  },
                  child: Text(
                    "Бизнес",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isBusiness
                          ? ColorResources.white
                          : ColorResources.darkGrey,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  color: isBusiness
                      ? CupertinoColors.secondarySystemFill
                      : ColorResources.accentRed,
                  onPressed: () {
                    setState(() {
                      isBusiness = false;
                    });
                  },
                  child: Text(
                    "Инспектор",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isBusiness
                          ? ColorResources.darkGrey
                          : ColorResources.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            textField("Адрес электронной почты"),
            SizedBox(height: 8),
            textField("Пароль"),
            Spacer(),
            SizedBox(height: 96),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isBusiness
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Нет аккаунта?"),
                SizedBox(
                  height: 24,
                  child: TextButton(
                    onPressed: () {
                      setState(() {

                      });
                    },
                    child: Text("Создать"),
                    style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(EdgeInsets.all(4)),
                      foregroundColor: MaterialStateProperty.all(
                          ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                )
              ],
            )
                : SizedBox(height: 0),
            SizedBox(height: 8),
            isBusiness
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Забыли пароль?"),
                SizedBox(
                  height: 24,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotEmail()),
                      );
                    },
                    child: Text("Восстановить"),
                    style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(EdgeInsets.all(4)),
                      foregroundColor: MaterialStateProperty.all(
                          ColorResources.accentRed),
                      overlayColor: MaterialStateProperty.all(
                        ColorResources.accentRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                )
              ],
            )
                : SizedBox(height: 0),
            SizedBox(height: 12),
            Container(
              height: 48,
              width: double.infinity,
              child: CupertinoButton(
                color: ColorResources.accentRed,
                onPressed: () {
                  apiClient.createBusinessUser(
                    CreateBusinessUserRequest(

                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text("Войти"),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
