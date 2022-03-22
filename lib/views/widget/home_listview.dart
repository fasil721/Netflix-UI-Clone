import 'package:flutter/material.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';
import 'package:netfix/views/widget/item_view.dart';

class HomeListview extends StatefulWidget {
  const HomeListview({Key? key, required this.code}) : super(key: key);
  final int code;
  @override
  _PopularListviewState createState() => _PopularListviewState();
}

class _PopularListviewState extends State<HomeListview> {
  Future<List<Result>?>? movies;
  @override
  void initState() {
    movies = apiServices.fetchData(upcomingUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 160,
      width: 120,
      child: FutureBuilder<List<Result>?>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Result> datas = snapshot.data!;
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
                      imageUrl + datas[index].posterPath!,
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
