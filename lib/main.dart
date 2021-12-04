import 'package:flutter/material.dart';
import 'package:netfix/pages/home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xff121212),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) => setState(
          () {
            currentIndex = index;
          },
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.gamepad_sharp,
            ),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_library,
            ),
            label: "Coming soon",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sentiment_very_satisfied,
            ),
            label: "fast Laughs",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download,
            ),
            label: "downloads",
          ),
        ],
      ),
    );
  }
}
