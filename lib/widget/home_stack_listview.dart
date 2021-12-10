import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/api/api.dart';
import 'package:netfix/design/colors.dart';
import 'package:bordered_text/bordered_text.dart';

class StackListView extends StatefulWidget {
  const StackListView({Key? key}) : super(key: key);

  @override
  _StackListViewState createState() => _StackListViewState();
}

class _StackListViewState extends State<StackListView> {
  Future<List>? datas;
  @override
  void initState() {
    datas = Api.topRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 160,
      child: FutureBuilder(
        future: datas,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List movies = snapshot.data as List;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    Container(
                      color: black,
                      width: index == 9 ? 185 : 140,
                      height: 120,
                    ),
                    Positioned(
                      right: -10,
                      bottom: 0,
                      child: SizedBox(
                        height: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            imageUrl + movies[index]["poster_path"],
                            width: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: index == 0 ? 0 : -6,
                      bottom: -20,
                      child: BorderedText(
                        strokeWidth: 2,
                        strokeColor: white,
                        child: Text(
                          (index + 1).toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 90,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    index != 0
                        ? Container(
                            width: 25,
                            height: 160,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
