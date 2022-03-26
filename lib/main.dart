import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfix/services/tmdb_service.dart';
import 'package:netfix/views/screens/coming_soon/coming_soon.dart';
import 'package:netfix/views/screens/downloads.dart';
import 'package:netfix/views/screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => TmdbServices(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const ComingSoonPage(),
      const Downloads(),
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
              Icons.file_download_outlined,
            ),
            label: "Downloads",
          ),
        ],
      ),
    );
  }
}
