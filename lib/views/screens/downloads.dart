import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  final scroll = ScrollController();
  Future<List<Result>?>? movies;
  @override
  void initState() {
    movies = apiServices.fetchData(upcomingUrl);
    super.initState();
  }

  Widget contents(Result data) => Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imageUrl + data.backdropPath!,
                  fit: BoxFit.cover,
                  height: 85,
                  errorBuilder: (context, error, stackTrace) => Container(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title!,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "18+ | 1 Episodes | 1.1 GB",
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Icon(
              Icons.arrow_forward_ios,
              color: white.withOpacity(0.5),
              size: 15,
            ),
          ),
        ],
      );

  Widget images(String data, double h, double w) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          imageUrl + data,
          fit: BoxFit.cover,
          height: h,
          width: w,
          errorBuilder: (context, error, stackTrace) => Container(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              expandedHeight: 112,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    ListTile(
                      tileColor: black,
                      title: Text(
                        "Downloads",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          const ImageIcon(
                            AssetImage("assets/icons/search.png"),
                            color: white,
                          ),
                          const SizedBox(width: 15),
                          Image.network(
                            "https://ih0.redbubble.net/image.618427277.3222/flat,1000x1000,075,f.u2.jpg",
                            width: 25,
                            height: 25,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      tileColor: black,
                      minLeadingWidth: 20,
                      leading: Icon(
                        Icons.settings,
                        size: 20,
                        color: white.withOpacity(0.5),
                      ),
                      title: Text(
                        "Smart downloads",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: white.withOpacity(0.5),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          body: FutureBuilder<List<Result>?>(
            future: movies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Result> datas = snapshot.data!;
                datas = datas.reversed.toList();
                return ListView(
                  children: [
                    contents(datas[0]),
                    contents(datas[1]),
                    contents(datas[2]),
                    contents(datas[3]),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: Divider(
                        color: white,
                        height: 1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Indroducing Downloads for You",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Text(
                            "We'll download a persolised selection of movies and shows for you, so there's always something to watch on your phone.",
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder<List<Result>?>(
                            future: movies,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                List<Result> datas = snapshot.data!;
                                datas = datas.reversed.toList();
                                return Stack(
                                  children: [
                                    Align(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          color: grey.withOpacity(0.6),
                                        ),
                                        height: 240,
                                        width: 240,
                                      ),
                                    ),
                                    Positioned(
                                      top: 80,
                                      left: 65,
                                      child: RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                          -20 / 360,
                                        ),
                                        child: images(
                                          datas[9].posterPath!,
                                          170,
                                          120,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 80,
                                      right: 65,
                                      child: RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                          20 / 360,
                                        ),
                                        child: images(
                                          datas[8].posterPath!,
                                          170,
                                          120,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      child: images(
                                        datas[12].posterPath!,
                                        190,
                                        130,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: blue[700],
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "Set Up",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
