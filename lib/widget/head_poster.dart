import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/api/api.dart';
import 'package:netfix/design/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPoster extends StatelessWidget {
  const MainPoster({Key? key, required this.datas}) : super(key: key);
  final List datas;

  Widget dotIcon() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Icon(
          FontAwesomeIcons.ggCircle,
          color: blue,
          size: 4,
        ),
      );

  Widget textGenre(String txt) => Text(
        txt,
        style: GoogleFonts.poppins(
          color: white,
          fontSize: 12,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .65,
          child: Image.network(
            imageUrl + datas[5]["poster_path"],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: white),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.05),
                  black.withOpacity(0.5),
                  black.withOpacity(0.75),
                  black.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 80,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textGenre("Adrenailine Rush"),
                dotIcon(),
                textGenre("Inspiring"),
                dotIcon(),
                textGenre("Exciting"),
                dotIcon(),
                textGenre("Extreme Sports"),
              ],
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.add,
                    color: white,
                    size: 25,
                  ),
                  Text(
                    "My List",
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: white,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        size: 25,
                        color: black,
                      ),
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
              ),
              Column(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: white,
                  ),
                  Text(
                    "Info",
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
