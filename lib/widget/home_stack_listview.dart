import 'package:flutter/material.dart';
import 'package:netfix/api/api.dart';
import 'package:netfix/design/colors.dart';

class StackListView extends StatefulWidget {
  const StackListView({Key? key}) : super(key: key);

  @override
  _StackListViewState createState() => _StackListViewState();
}

class _StackListViewState extends State<StackListView> {
  Future<dynamic>? datas;
  @override
  void initState() {
    datas = Api.topRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 100,
      child: FutureBuilder(
        future: datas,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List movies = snapshot.data as List;
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imageUrl + movies[index]["poster_path"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
