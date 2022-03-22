import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/services/api_services.dart';

import 'item_view.dart';

class HomeListview extends StatefulWidget {
  const HomeListview({Key? key, required this.code}) : super(key: key);
  final int code;
  @override
  _PopularListviewState createState() => _PopularListviewState();
}

class _PopularListviewState extends State<HomeListview> {
  Future<List>? movies;
  @override
  void initState() {
    movies = ApiServices.upcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 160,
      width: 120,
      child: FutureBuilder(
        future: movies,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List datas = snapshot.data as List;
            if (widget.code == 2) {
              datas = datas.reversed.toList();
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: datas.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemView(movie: datas[index]),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      imageUrl + datas[index]["poster_path"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
            );
          }
          return Container();
        },
      ),
    );
  }
}
