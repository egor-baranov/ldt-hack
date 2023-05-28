import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/providers/LocalStorageProvider.dart';

import '../models/chat/Chat.dart';
import '../models/chat/Message.dart';
import '../styles/ColorResources.dart';
import '../utils/parser.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _controller = ScrollController();
  final _inputController = TextEditingController();

  ChatHolder chat = ChatHolder([]);

  @override
  void initState() {
    super.initState();
    storageProvider.getChat().then(
          (value) => setState(
            () {
              chat = value;
              print(chat.toJson());
              Future.delayed(
                Duration(milliseconds: 50),
                () {
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.ease,
                  );
                },
              );
            },
          ),
        );
  }

  void _scrollDown([int delay = 100]) {
    Future.delayed(Duration(milliseconds: delay), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  Widget rateCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: ColorResources.accentRed,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      sendMessage(
                        "Спасибо за обратную связь, рад помочь!",
                        false,
                        [],
                      );
                    },
                    icon: const Icon(
                      Icons.thumb_up_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      sendMessage("Вот, что еще удалось найти:", false, [
                        "Список нормативных актов",
                        "Список органов контроля",
                        "Список обязательных требований"
                      ]);
                    },
                    icon: const Icon(
                      Icons.thumb_down_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget chatCard(String text, bool my, List<String> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              my ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Card(
                color: my
                    ? ColorResources.accentRed
                    : CupertinoColors.lightBackgroundGray,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        softWrap: true,
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
        (my || results.isEmpty) ? SizedBox() : rateCard(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget chatInput() {
    return GestureDetector(
      onTap: () => _scrollDown(),
      child: Container(
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
                onChanged: (text) => _scrollDown,
                onTap: _scrollDown,
                controller: _inputController,
                cursorColor: Colors.black,
                onSubmitted: (String text) {
                  sendMessage(text, true, []);
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
              icon: const Icon(Icons.send_rounded,
                  color: ColorResources.darkGrey),
              onPressed: () {
                if (!isBlank(_inputController.text)) {
                  sendMessage(_inputController.text, true, []);
                  _inputController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void processResponse(String text) {
    setState(() {
      final message = Message(
        text: "Самые релевантные данные по вашему запросу:",
        sentByUser: false,
        results: [
          "Список нормативных актов",
          "Список органов контроля",
          "Список обязательных требований"
        ],
      );
      chat.messages.add(message);
      storageProvider.saveChat(chat);
      _scrollDown();
    });
  }

  void sendMessage(String text, bool byUser, List<String> results) {
    if (isBlank(text)) {
      return;
    }

    setState(() {
      final message = Message(
        text: text,
        sentByUser: byUser,
        results: results,
      );

      chat.messages.add(message);
      storageProvider.saveChat(chat);

      if (byUser) {
        processResponse(text);
      } else {
        _scrollDown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: chatInput(),
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          controller: _controller,
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                "Чат",
                style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
              ),
              trailing: Material(
                child: IconButton(
                  onPressed: () {
                    // widget.onSearch();
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    if (chat.messages.isEmpty)
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 300),
                            child: Text(
                              "Сообщений пока нет: напишите любой вопрос и бот даст на него ответ",
                              softWrap: true,
                              maxLines: 3,
                              style: GoogleFonts.ptSerif(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                    ...chat.messages.map(
                      (e) => chatCard(e.text, e.sentByUser, e.results),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
