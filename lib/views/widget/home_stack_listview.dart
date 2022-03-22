import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';

class StackListView extends StatefulWidget {
  const StackListView({Key? key}) : super(key: key);

  @override
  _StackListViewState createState() => _StackListViewState();
}

class _StackListViewState extends State<StackListView> {
  Future<List<Result>?>? datas;
  @override
  void initState() {
    datas = apiServices.fetchData(discoverUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 160,
      child: FutureBuilder<List<Result>?>(
        future: datas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final movies = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.zero,
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
                            imageUrl + movies[index].posterPath!,
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
                    if (index != 0)
                      Container(
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
                    else
                      Container()
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
