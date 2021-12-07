import 'dart:convert';
import 'package:http/http.dart';

const imageUrl = "https://image.tmdb.org/t/p/w500";
const topRatedUrl =
    "https://api.themoviedb.org/3/movie/top_rated?api_key=cef190df496ba948f6fb61fa17f0cc62";
const trending =
    "https://api.themoviedb.org/3/trending/all/day?api_key=cef190df496ba948f6fb61fa17f0cc62";
const discover =
    "https://api.themoviedb.org/3/discover/movie?api_key=cef190df496ba948f6fb61fa17f0cc62";
const all =
    "https://api.themoviedb.org/3/movie/550?api_key=cef190df496ba948f6fb61fa17f0cc62";
const upcoming =
    "https://api.themoviedb.org/3/movie/upcoming?api_key=cef190df496ba948f6fb61fa17f0cc62";
const genres =
    "https://api.themoviedb.org/3/genre/movie/list?api_key=cef190df496ba948f6fb61fa17f0cc62";

class Api {
  static Future<List> trendingMovies() async {
    try {
      final response = await get(Uri.parse(trending));
      final Map jsonData = await json.decode(response.body);
      return jsonData['results'];
    } catch (err) {
      return [];
    }
  }

  static Future<List> topRatedMovies() async {
    try {
      final response = await get(Uri.parse(discover));
      final Map jsonData = await json.decode(response.body);
      return jsonData['results'];
    } catch (err) {
      return [];
    }
  }

  static Future<List> upcomingMovies() async {
    try {
      final response = await get(Uri.parse(upcoming));
      final Map jsonData = await json.decode(response.body);
      return jsonData['results'];
    } catch (err) {
      return [];
    }
  }

  static Future<List> genre() async {
    try {
      final response = await get(Uri.parse(genres));
      final Map jsonData = await json.decode(response.body);
      return jsonData['genres'];
    } catch (err) {
      return [];
    }
  }
}
