import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/screens/widget/catagories.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
    required this.notifier,
    required this.offset,
    required this.yOffset,
  }) : super(key: key);
  final ValueNotifier<double> notifier;
  final double offset;
  final double yOffset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        errorBuilder: (context, error, stackTrace) =>
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
                            builder: (context) => const Catogories(),
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
    );
  }
}
