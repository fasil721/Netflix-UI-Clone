import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';

class ApiServices {
  Future<List<Result>?> fetchData(String url) async {
    final mainUrl = "$baseUrl$url$apiKey";
    try {
      final response = await http.get(Uri.parse(mainUrl));
      if (response.statusCode == 200) {
        final jsonData = await json.decode(response.body);
        final datas =
            MovieModel.fromJson(Map<String, dynamic>.from(jsonData as Map));
        return datas.results;
      }
      final jsonData = await json.decode(response.body);
      final datas =
          MovieModel.fromJson(Map<String, dynamic>.from(jsonData as Map));
      return datas.results;
    } on HttpException {
      Fluttertoast.showToast(msg: "No Internet");
    } on SocketException {
      Fluttertoast.showToast(msg: "No internet connection");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Invalid Format");
    // } catch (e) {
    //   Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  // static Future<List??> topRatedMovies1() async {
  //   const url = "$baseUrl/discover/movie?$apiKey";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final Map jsonData = await json.decode(response.body);
  //     return jsonData['results'];
  //   } catch (err) {
  //     return [];
  //   }
  // }

  // static Future<List?> upcomingMovies1() async {
  //   const url = "$baseUrl/movie/upcoming?$apiKey";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final Map jsonData = await json.decode(response.body);
  //     return jsonData['results'];
  //   } catch (err) {
  //     return [];
  //   }
  // }

  Future<List> genre() async {
    const url = "$baseUrl/genre/movie/list?$apiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final Map jsonData = await json.decode(response.body);
      return jsonData['genres'];
    } catch (err) {
      return [];
    }
  }
}
