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
              _scrollDown(200);
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
              icon: const Icon(Icons.send_rounded,
                  color: ColorResources.darkGrey),
              onPressed: () {
                if (!isBlank(_inputController.text)) {
                  sendMessage(_inputController.text);
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
        text: "Вот все, что удалось найти по вашему запросу:",
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

  void sendMessage(String text) {
    if (isBlank(text)) {
      return;
    }

    setState(() {
      final message = Message(
        text: text,
        sentByUser: true,
        results: [],
      );

      chat.messages.add(message);
      storageProvider.saveChat(chat);
      processResponse(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: chatInput(),
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        ...chat.messages.map(
                          (e) => chatCard(e.text, e.sentByUser, e.results),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
