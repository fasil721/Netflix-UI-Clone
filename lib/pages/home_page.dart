import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/design/colors.dart';
import 'package:netfix/widget/home_listview.dart';
import 'package:netfix/widget/home_stack_listview.dart';
import 'package:netfix/widget/main_poster.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.datas}) : super(key: key);
  final List datas;
  final scroll = ScrollController();

  Widget headings(String txt) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              color: white, fontSize: 17, fontWeight: FontWeight.w500),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: black,
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   toolbarOpacity: 0,
      //   elevation: 0,
      //   // bottom: PreferredSize(
      //   //   preferredSize: Size(100, 50),
      //   //   child: Container(
      //   //     height: 100,
      //   //   ),
      //   // ),
      //   backgroundColor: Colors.black.withOpacity(0.1),
      // ),
      body: Stack(
        children: [
          ListView(
            controller: scroll,
            physics: const BouncingScrollPhysics(),
            children: [
              MainPoster(datas: datas),
              headings("Popular On Netflix"),
              homeListView(datas),
              headings("Trending Now"),
              homeListView(datas.reversed.toList()),
              headings("Top 10 Rated in India"),
              const StackListView(),
            ],
          ),
        ],
      ),
    );
  }
}
