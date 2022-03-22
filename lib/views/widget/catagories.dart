import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';

class Catogories extends StatelessWidget {
  const Catogories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black.withOpacity(0.7),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: const Alignment(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Home",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ...catogories.map(
                  (e) => Align(
                    alignment: const Alignment(0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        e,
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          color: white.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: white.withOpacity(0.9),
                ),
                height: 60,
                width: 60,
                child: const Icon(Icons.close, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
