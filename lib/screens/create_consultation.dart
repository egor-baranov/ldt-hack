import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lodt_hack/main.dart';
import 'package:lodt_hack/models/consultation/Consultation.dart';
import 'package:lodt_hack/styles/ColorResources.dart';
import 'package:google_fonts/google_fonts.dart';

import '../clients/ApiClient.dart';
import '../generated/google/protobuf/empty.pb.dart';
import '../models/consultation/ConsultationHolder.dart';
import '../providers/LocalStorageProvider.dart';
import '../utils/parser.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:grpc/grpc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreateConsultation extends StatefulWidget {
  const CreateConsultation({super.key});

  @override
  State<CreateConsultation> createState() => _CreateConsultationState();
}

class _CreateConsultationState extends State<CreateConsultation> {
  ConsultationHolder consultations = ConsultationHolder([]);
  ConsultationModel consultation = ConsultationModel();

  final createConsultationFormKey = GlobalKey<FormState>();
  String? token;

  List<int> authorityIds = [];
  List<String> authorityNames = [];

  String selectedAuthority = "";

  void fetchData() {
    storageProvider.getConsultations().then(
          (value) => setState(
            () {
              consultations = value;
              print(consultations.toJson());
            },
          ),
        );

    storageProvider.getToken().then(
          (value) => setState(
            () {
              token = value!;
              getConsultationTopics();
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void getConsultationTopics() async {
    try {
      final response = await apiClient.listConsultationTopics(
        Empty(),
        options: CallOptions(
          metadata: {'Authorization': 'Bearer $token'},
        ),
      );

      setState(() {
        authorityIds = response.authorityTopics
            .map((e) => e.authorityId.toInt())
            .toSet()
            .toList();

        authorityNames = response.authorityTopics
            .map((e) => e.authorityName.length > 35
                ? e.authorityName.substring(0, 35)
                : e.authorityName)
            .toSet()
            .toList();

        print(authorityNames);
      });
    } on GrpcError catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка получения данных"),
            content: Text(e.message ?? "Текст ошибки отсутствует"),
            actions: [
              TextButton(
                child: Text("Продолжить"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
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

  Widget dropdownList() {
    return DropdownButton2(
      hint: const Text('Контрольно-надзорный орган'),
      items: authorityNames
          .toSet()
          .toList()
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                softWrap: true,
                maxLines: 5,
              ),
            ),
          )
          .toList(),
      onChanged: (v) {
        setState(() {
          selectedAuthority = v as String;
        });
      },
      buttonStyleData: const ButtonStyleData(
        height: 80,
        width: 400,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 80,
      ),
      dropdownStyleData: DropdownStyleData(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
    );

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          'Контрольно-надзорный орган',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: authorityNames
            .toSet()
            .toList()
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        isExpanded: true,
        value: selectedAuthority,
        onChanged: (value) {
          setState(() {
            selectedAuthority = value as String;
          });
        },
        buttonStyleData: const ButtonStyleData(
          height: 40,
          width: 300,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
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
                        dropdownList(),
                        textField("Контрольно-надзорный орган", (value) {
                          if (isBlank(value)) {
                            return "Поле КНО не должно быть пустым";
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
                                storageProvider
                                    .saveConsultations(consultations);
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
