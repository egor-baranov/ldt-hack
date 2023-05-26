import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Message.dart';
import '../styles/ColorResources.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  static final List<Message> _messages = [];

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final _inputController = TextEditingController();

  Widget chatCard(String text, bool my, List<String> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              my ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Card(
                color: my
                    ? ColorResources.accentRed
                    : CupertinoColors.lightBackgroundGray,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                            color: (my ? Colors.white : Colors.black)),
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ...results.map(
          (e) => Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8),
            child: Material(
              color: ColorResources.accentRed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget chatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      color: CupertinoColors.systemGrey5,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.keyboard_voice_outlined,
              color: ColorResources.darkGrey,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _inputController,
              cursorColor: Colors.black,
              onSubmitted: (String text) {
                sendMessage(text);
                _inputController.clear();
              },
              decoration: InputDecoration(
                hintText: "Введите запрос...",
                hintStyle: const TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon:
                const Icon(Icons.send_rounded, color: ColorResources.darkGrey),
            onPressed: () {
              if (_inputController.text.isNotEmpty) {
                sendMessage(_inputController.text);
                _inputController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void processResponse(String text) {
    setState(() {
      Chat._messages.add(const Message(
          text: "Вот все, что удалось найти по вашему запросу:",
          sentByUser: false,
          results: [
            "Список нормативных актов",
            "Список органов контроля",
            "Список обязательных требований"
          ]));
    });
  }

  void sendMessage(String text) {
    setState(() {
      Chat._messages.add(Message(
        text: text,
        sentByUser: true,
        results: [],
      ));
      processResponse(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  ...Chat._messages.map(
                    (e) => chatCard(e.text, e.sentByUser, e.results),
                  )
                ],
              ),
            ),
          ),
        ),
        chatInput()
      ],
    );
  }
}
