import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:netfix/api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();

  @override
  void initState() {
    dataFetching();
    super.initState();
  }

  Future<List?> dataFetching() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = await json.decode(response.body) as Map;
      print("noError");
      return jsonData['results'];
    } catch (err) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: dataFetching(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List a = snapshot.data as List;
              return ListView(
                controller: scroll,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        ImageUrl + a[1]["poster_path"],
                        height: 500,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: a.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                              ImageUrl + a[index]["poster_path"],
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
