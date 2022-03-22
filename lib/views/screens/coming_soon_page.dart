import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  State<ComingSoonPage> createState() => _ComingSoonViewState();
}

class _ComingSoonViewState extends State<ComingSoonPage> {
  final scroll = ScrollController();

  final ValueNotifier<double> notifier = ValueNotifier(0);
  Future<List<Result>?>? movies;
  @override
  void initState() {
    movies = apiServices.fetchData(upcomingUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        tileColor: black,
                        title: Text(
                          "Coming Soon",
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
                    ),
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        tileColor: black,
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
                    ),
                  ],
                ),
              ),
            )
          ],
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Result>?>(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final datas = snapshot.data!;
                  return ListView.builder(
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      String date;
                      date = controller.datePicker(datas[index].releaseDate!);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Image.network(
                                  imageUrl + datas[index].backdropPath!,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(),
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
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Coming On $date",
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
                              datas[index].title!,
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
                              datas[index].overview!,
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
                              future: controller
                                  .genrePicker(datas[index].genreIds!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
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
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                  ),
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
                          )
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
