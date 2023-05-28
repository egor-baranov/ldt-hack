import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/models/consultation/Consultation.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/consultation/ConsultationHolder.dart';
import '../providers/LocalStorageProvider.dart';
import '../utils/parser.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CreateConsultation extends StatefulWidget {
  const CreateConsultation({super.key});

  @override
  State<CreateConsultation> createState() => _CreateConsultationState();
}

class _CreateConsultationState extends State<CreateConsultation> {
  ConsultationHolder consultations = ConsultationHolder([]);
  ConsultationModel consultation = ConsultationModel();
  final createConsultationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    storageProvider.getConsultations().then(
          (value) => setState(
            () {
              consultations = value;
              print(consultations.toJson());
            },
          ),
        );
  }

  Widget textField(String label, String? Function(String?)? validator,
      Function(String)? onChanged, TextInputFormatter? inputFormatter) {
    return TextFormField(
      cursorColor: Colors.black,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatter == null ? [] : [inputFormatter],
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
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                "Запись",
                style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: createConsultationFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        SizedBox(height: 16),
                        const Text(
                          "Запишитесь на консультацию с инспектором в удобное время, а перед ее началом вам придет уведомление",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        SizedBox(height: 32),
                        textField("Тема", (value) {
                          if (isBlank(value)) {
                            return "Тема не должна быть пустой";
                          }
                        }, (text) {
                          consultation.title = text;
                        }, null),
                        SizedBox(height: 8),
                        textField("Описание", (value) {
                          if (isBlank(value)) {
                            return "Описание не должно быть пустым";
                          }
                        }, (text) {
                          consultation.description = text;
                        }, null),
                        SizedBox(height: 8),
                        textField("Дата начала", (value) {
                          if (isBlank(value)) {
                            return "Дата начала не должна быть пустой";
                          }
                        }, (text) {
                          consultation.day = text;
                        }, MaskedInputFormatter("00.00.0000")),
                        SizedBox(height: 8),
                        textField(
                          "Время начала",
                          (value) {
                            if (isBlank(value)) {
                              return "Время начала не должно быть пустым";
                            }
                          },
                          (text) {
                            consultation.time = text;
                          },
                          MaskedInputFormatter("00:00"),
                        ),
                        SizedBox(height: 32),
                        Container(
                          height: 48,
                          width: double.infinity,
                          child: CupertinoButton(
                            color: ColorResources.accentRed,
                            onPressed: () {
                              if (createConsultationFormKey.currentState!
                                  .validate()) {
                                consultation.tags = ["Есть запись"];
                                consultations.consultations.add(consultation);
                                storageProvider.saveConsultations(consultations);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Записаться на консультацию",
                              style: TextStyle(
                                color: ColorResources.white,
                              ),
                            ),
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
                            child: const Text(
                              "Отменить создание записи",
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
            ),
          ],
        ),
      ),
    );
  }
}
