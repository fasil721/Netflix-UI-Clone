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
      height: 150,
      child: FutureBuilder(
        future: datas,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List movies = snapshot.data as List;
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 130,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            imageUrl + movies[index]["poster_path"],
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: white),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: BorderedText(
                          strokeWidth: 4,
                          strokeColor: white,
                          child: Text(
                            (index + 1).toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 75,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
