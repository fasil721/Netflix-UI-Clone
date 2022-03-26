import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/functions.dart';
import 'package:netfix/models/movie_models.dart';

class ItemView extends StatelessWidget {
  const ItemView({Key? key, required this.movie}) : super(key: key);
  final Result movie;
  @override
  Widget build(BuildContext context) {
    final String date = datePicker(movie.releaseDate!);
    final String temp = movie.releaseDate!;
    final year = temp.split("").toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          toolbarHeight: 70,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            const ImageIcon(
              AssetImage("assets/icons/search.png"),
              color: white,
            ),
            const SizedBox(width: 15),
            Image.network(
              "https://ih0.redbubble.net/image.618427277.3222/flat,1000x1000,075,f.u2.jpg",
              width: 25,
              height: 25,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    imageUrl + movie.backdropPath!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(),
                  ),
                  Align(
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: white),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: white,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Text(
                movie.title!,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Released On $date ${year[0]}${year[1]}${year[2]}${year[3]}",
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_arrow,
                    size: 25,
                    color: black,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Play",
                    style: GoogleFonts.poppins(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: grey.withOpacity(0.5),
              ),
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.file_download_outlined,
                    size: 25,
                    color: white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Download",
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                movie.overview!,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: FutureBuilder<List<String>>(
                future: genrePicker(movie.genreIds!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final _genres = snapshot.data!;
                    return Row(
                      children: [
                        ..._genres.map(
                          (element) {
                            return Row(
                              children: [
                                Text(
                                  element,
                                  style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    color: white,
                                  ),
                                ),
                                if (_genres.last != element)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Icon(
                                      FontAwesomeIcons.ggCircle,
                                      color: blue,
                                      size: 4,
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            );
                          },
                        )
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.add,
                      color: white,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "My List",
                      style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.thumb_up_outlined,
                      color: white,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Rate",
                      style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.share,
                      color: white,
                      size: 30,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Share",
                      style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
