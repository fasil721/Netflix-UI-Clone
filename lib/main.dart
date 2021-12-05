import 'package:flutter/material.dart';
import 'package:netfix/api/api.dart';
import 'package:netfix/pages/home_page.dart';

void main() async {
  final List datas = await Api.trendingMovies();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(data: datas),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.data}) : super(key: key);
  final List data;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(datas: widget.data),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
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
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              currentIndex == 0
                  ? const AssetImage("assets/icons/home2.png")
                  : const AssetImage("assets/icons/home1.png"),
              size: 25,
            ),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.gamepad_sharp,
          //   ),
          //   label: "Games",
          // ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              currentIndex == 1
                  ? const AssetImage("assets/icons/video2.png")
                  : const AssetImage("assets/icons/video1.png"),
              size: 25,
            ),
            label: "Coming soon",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.sentiment_very_satisfied,
          //   ),
          //   label: "fast Laughs",
          // ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.offline_bolt_rounded,
            ),
            label: "downloads",
          ),
        ],
      ),
    );
  }
}
