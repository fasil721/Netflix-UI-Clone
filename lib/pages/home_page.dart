import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/api/functions.dart';
import 'package:netfix/design/colors.dart';
import 'package:netfix/widget/home_listview.dart';
import 'package:netfix/widget/home_stack_listview.dart';
import 'package:netfix/widget/head_poster.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();
  double offset = 1;
  final ValueNotifier<double> notifier = ValueNotifier(0);

  @override
  void initState() {
    notifier.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, _) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: black,
              appBar: AppBar(
                toolbarOpacity: 0,
                elevation: 0,
                backgroundColor:
                    Colors.black.withOpacity(notifier.value < 100 ? 0.2 : 1),
                bottom: PreferredSize(
                  preferredSize: Size(0, notifier.value > 100 ? -14 : 42),
                  child: Column(
                    children: [
                      SizedBox(
                        height: notifier.value < 100 ? 40 * offset : 0,
                        child: ListTile(
                          leading: Image.asset(
                            "assets/icons/netflix.png",
                            height: notifier.value < 100 ? 40 * offset : 0,
                          ),
                          trailing: Wrap(
                            children: [
                              Image.asset(
                                "assets/icons/search.png",
                                height: notifier.value < 100 ? 30 * offset : 0,
                              ),
                              const SizedBox(width: 15),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.network(
                                  "https://ih0.redbubble.net/image.618427277.3222/flat,1000x1000,075,f.u2.jpg",
                                  height:
                                      notifier.value < 100 ? 27 * offset : 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "TV Shows",
                              style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Movies",
                              style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Categories",
                              style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: NotificationListener(
                onNotification: (notify) {
                  if (notify is ScrollEndNotification) {
                    notifier.value = scroll.position.pixels;
                    if (scroll.position.pixels < 100) {
                      offset = (100 - notify.metrics.pixels) / 100;
                      print(offset);
                    }
                  }

                  return false;
                },
                child: ListView(
                  padding: const EdgeInsets.only(top: 0),
                  controller: scroll,
                  physics: const ScrollPhysics(),
                  children: [
                    const MainPoster(),
                    headings("Popular On Netflix"),
                    const HomeListview(code: 1),
                    headings("Trending Now"),
                    const HomeListview(code: 2),
                    headings("Top 10 Rated in India"),
                    const StackListView(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
