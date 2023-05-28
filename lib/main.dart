import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/screens/account/account.dart';
import 'package:lodt_hack/screens/auth/auth.dart';
import 'package:lodt_hack/styles/ColorResources.dart';

import 'screens/chat.dart';
import 'screens/dashboard.dart';
import 'screens/zoom.dart';
import 'styles/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business checks app',
      theme: light,
      home: MyHomePage(title: 'Business checks app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      // appBar: AppBar(toolbarHeight: 32),
      body: SafeArea(
          child: [
            Dashboard(onSearch: () {
              setState(() {
                Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Auth()),
                );
              });
            }),
            Chat(),
            Zoom(),
            Account()
          ][_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorResources.accentRed,
        unselectedItemColor: CupertinoColors.systemGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: "Главная",
            backgroundColor: CupertinoColors.systemGrey6,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: "Чат",
            backgroundColor: CupertinoColors.systemGrey6,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.videocam_fill),
            label: "Консультации",
            backgroundColor: CupertinoColors.systemGrey6,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Профиль",
            backgroundColor: CupertinoColors.systemGrey6,
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
