import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Message.dart';
import '../styles/ColorResources.dart';

class Chat extends StatefulWidget {

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}



class _ChatState extends State<Chat> {

  Widget chatCard(String text, bool my) {
    return Row(
      mainAxisAlignment: my ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            color: my ? CupertinoColors.lightBackgroundGray : Colors.blue,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(color: (my ? Colors.black : Colors.white)),
                maxLines: 10,
              ),
            ),
          ),
        ),
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
            icon: Icon(Icons.keyboard_voice_outlined,
                color: ColorResources.darkGrey),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Введите запрос...",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_rounded, color: ColorResources.darkGrey),
            onPressed: () {},
          ),
        ],
      ),
    );
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
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                      "Здравствуйте, нужно согласовать очень длинный запрос: trpov pdsiofp sdpifpcv  pifdspofi psdifpoi iposdifpisd poidspofidpi psidpfip ipgisdpfi pisdpf",
                      true),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                    "Здравствуйте, нужно согласовать очень длинный запрос: ",
                    true,
                  ),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                      "Здравствуйте, нужно согласовать очень длинный запрос: trpov pdsiofp sdpifpcv  pifdspofi psdifpoi iposdifpisd poidspofidpi psidpfip ipgisdpfi pisdpf",
                      true),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                    "Здравствуйте, нужно согласовать очень длинный запрос: ",
                    true,
                  ),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                      "Здравствуйте, нужно согласовать очень длинный запрос: trpov pdsiofp sdpifpcv  pifdspofi psdifpoi iposdifpisd poidspofidpi psidpfip ipgisdpfi pisdpf",
                      true),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard("Добрый день, с чем я могу вам помочь?", false),
                  chatCard(
                    "Здравствуйте, нужно согласовать очень длинный запрос: ",
                    true,
                  ),
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
