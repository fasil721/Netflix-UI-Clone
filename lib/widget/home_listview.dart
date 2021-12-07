import 'package:flutter/cupertino.dart';
import 'package:netfix/api/api.dart';

import 'package:netfix/design/colors.dart';

Widget homeListView(List datas) {
  return Container(
    margin: const EdgeInsets.all(10),
    height: 150,
    width: 100,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: datas.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            imageUrl + datas[index]["poster_path"],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: white,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: 10),
    ),
  );
}
