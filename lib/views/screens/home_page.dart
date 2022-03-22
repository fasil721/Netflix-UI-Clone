import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/views/widget/catagories.dart';
import 'package:netfix/views/widget/head_poster.dart';
import 'package:netfix/views/widget/home_listview.dart';
import 'package:netfix/views/widget/home_stack_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();
  double offset = 1;
  double yOffset = 0;
  bool reverse = false;
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
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            backgroundColor: black,
            appBar: AppBar(
              toolbarOpacity: 0,
              elevation: 0,
              backgroundColor: Colors.black.withOpacity(
                notifier.value < 100 ? (1.00 - offset) * 0.8 : 0.8,
              ),
              bottom: PreferredSize(
                preferredSize:
                    notifier.value < 100 ? Size(0, 42 * offset) : Size.zero,
                child: SizedBox(
                  height: notifier.value < 100 ? (60 * offset) + 38 : 38,
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 1),
                          transform: Matrix4.translationValues(0, yOffset, 0),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/icons/netflix.png",
                              height: 40,
                            ),
                            trailing: Wrap(
                              children: [
                                Image.asset(
                                  "assets/icons/search.png",
                                  height: 30,
                                ),
                                const SizedBox(width: 15),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Image.network(
                                    "https://ih0.redbubble.net/image.618427277.3222/flat,1000x1000,075,f.u2.jpg",
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(),
                                    height: 27,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 38,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "TV Shows",
                                style: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Movies",
                                style: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Categories",
                                    style: GoogleFonts.poppins(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const Catogories(),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: NotificationListener(
              onNotification: (noti) {
                notifier.value = scroll.position.pixels;
                if (scroll.position.pixels < 100) {
                  offset = (100 - scroll.position.pixels) / 100;
                  yOffset = -notifier.value * .7;
                }
                // if (scroll.position.userScrollDirection ==
                //     ScrollDirection.forward) {
                //   reverse = true;
                //   // print("reverse");
                // }
                // if (scroll.position.userScrollDirection ==
                //     ScrollDirection.reverse) {
                //   reverse = false;
                //   // print("forward");
                // }

                return false;
              },
              child: ListView(
                padding: EdgeInsets.zero,
                controller: scroll,
                physics: const ScrollPhysics(),
                children: [
                  const MainPoster(),
                  controller.headings("Popular On Netflix"),
                  const HomeListview(code: 1),
                  controller.headings("Trending Now"),
                  const HomeListview(code: 2),
                  controller.headings("Top 10 Rated in India"),
                  const StackListView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
