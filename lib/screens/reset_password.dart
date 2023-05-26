import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
              "Восстановить пароль",
              style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    const Text(
                      "Письмо с восстановлением пароля будет отправлено на указанный вами адрес электронной почты",
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    SizedBox(height: 32),
                    textField("Адрес электронной почты"),
                    SizedBox(height: 32),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: CupertinoButton(
                        color: ColorResources.accentRed,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Отправить на почту"),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: CupertinoButton(
                        color: ColorResources.accentPink,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Отменить",
                          style: TextStyle(
                            color: ColorResources.accentRed,
                          ),
                        ),
                      ),
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
