import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';

// const topRatedUrl = "$baseUrl/movie/top_rated?api_key=$apiKey";
// const all = "$baseUrl/movie/550?api_key=$apiKey";

class ApiServices {
  static Future<List<Result>?> trendingMovies() async {
    const url = "$baseUrl/trending/all/day?$apiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = await json.decode(response.body);
      final datas = MovieModel.fromJson(Map<String, dynamic>.from(jsonData));
      print(datas.results!.map((e) => e.title));
      return datas.results;
    } on HttpException {
      Fluttertoast.showToast(msg: "No Internet");
    } on SocketException {
      Fluttertoast.showToast(msg: "No internet connection");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Invalid Format");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  static Future<List> topRatedMovies() async {
    const url = "$baseUrl/discover/movie?$apiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final Map jsonData = await json.decode(response.body);
      return jsonData['results'];
    } catch (err) {
      return [];
    }
  }

  static Future<List> upcomingMovies() async {
    const url = "$baseUrl/movie/upcoming?$apiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final Map jsonData = await json.decode(response.body);
      return jsonData['results'];
    } catch (err) {
      return [];
    }
  }

  static Future<List> genre() async {
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
