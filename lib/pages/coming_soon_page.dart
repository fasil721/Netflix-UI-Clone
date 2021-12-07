import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/api/api.dart';
import 'package:netfix/api/functions.dart';
import 'package:netfix/design/colors.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  State<ComingSoonPage> createState() => _ComingSoonViewState();
}

class _ComingSoonViewState extends State<ComingSoonPage> {
  final scroll = ScrollController();

  final ValueNotifier<double> notifier = ValueNotifier(0);
  Future<List>? movies;
  @override
  void initState() {
    movies = Api.upcomingMovies();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        children: [
          AppBar(
            backgroundColor: black,
            toolbarHeight: 60,
            elevation: 0,
            title: Text(
              "Coming Soon",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
              ),
              const SizedBox(width: 15),
            ],
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const Icon(
              Icons.notifications_none_sharp,
              color: white,
            ),
            title: Text(
              "Notifications",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: white,
              size: 15,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 240,
            child: FutureBuilder(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List datas = snapshot.data as List;
                  return ListView.builder(
                    controller: scroll,
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      String date;
                      date = datePicker(datas[index]["release_date"]);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Image.network(
                                  imageUrl + datas[index]["backdrop_path"],
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: const Alignment(0, 0),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(50),
                                      border:
                                          Border.all(width: 1, color: white),
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
                          // SizedBox(
                          //   height: 100,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         flex: 6,
                          //         child: Text(
                          //           datas[index]["title"],
                          //           style: GoogleFonts.roboto(
                          //             fontSize: 20,
                          //             color: white,
                          //           ),
                          //         ),
                          //       ),
                          //       const Expanded(
                          //         child: Icon(
                          //           Icons.notifications_none,
                          //           color: white,
                          //         ),
                          //       ),
                          //       const Expanded(
                          //         child: Icon(
                          //           Icons.notifications_none,
                          //           color: white,
                          //         ),
                          //       ),
                          //       const SizedBox(),
                          //     ],
                          //   ),
                          // ),
                          // ListTile(
                          // title: Text(
                          //   datas[index]["title"],
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 15,
                          //     color: white,
                          //   ),
                          // ),
                          //   trailing: Wrap(
                          //     children: const [
                          //       Icon(
                          //         Icons.notifications_none,
                          //         color: white,
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Icon(
                          //         Icons.info_outline,
                          //         color: white,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Coming On " + date,
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              datas[index]["title"],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              datas[index]["overview"],
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
                            child: FutureBuilder(
                              future: genrePicker(datas[index]["genre_ids"]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  List _genres = snapshot.data as List;
                                  return Row(
                                    children: [
                                      ..._genres.map(
                                        (element) {
                                          return Row(
                                            children: [
                                              Text(
                                                element,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13, color: white),
                                              ),
                                              _genres.last != element
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .ggCircle,
                                                        color: blue,
                                                        size: 4,
                                                      ),
                                                    )
                                                  : const SizedBox(),
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
                          )
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
