import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/services/tmdb_service.dart';

Widget headings(String txt) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        txt,
        style: GoogleFonts.poppins(
          color: white,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

String datePicker(String date) {
  final temp = date.split("");
  final String day = temp[8] + temp[9];
  final String month = temp[5] + temp[6];
  if (month == "01") {
    return "$day January";
  } else if (month == "02") {
    return "$day February";
  } else if (month == "03") {
    return "$day March";
  } else if (month == "04") {
    return "$day April";
  } else if (month == "05") {
    return "$day May";
  } else if (month == "06") {
    return "$day June";
  } else if (month == "07") {
    return "$day July";
  } else if (month == "08") {
    return "$day Augest";
  } else if (month == "09") {
    return "$day September";
  } else if (month == "10") {
    return "$day October";
  } else if (month == "11") {
    return "$day November";
  }
  return "$day December";
}

Future<List<String>> genrePicker(List datas) async {
  final genres = await TmdbServices().genre();
  final List<String> _genres = [];
  final List temp = datas;
  for (final i in genres!) {
    for (final j in temp) {
      if (i.id == j) {
        _genres.add(i.name!);
      }
    }
  }
  return _genres;
}

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
