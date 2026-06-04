import 'dart:convert';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TmbdServices {
  
  Future<List<Movie>> getPopularMovies() async {
    return await _fetchMovies(ApiServices.popular);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    return await _fetchMovies(ApiServices.nowPlaying);
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return await _fetchMovies(ApiServices.topRated);
  }

  Future<List<Movie>> getUpcomingMovies() async {
    return await _fetchMovies(ApiServices.upcoming);
  }

  Future<List<Movie>> _fetchMovies(String endPoint) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiServices.baseUrl}$endPoint?api_key=${ApiServices.apiKey}&language=en-US&page=1',
        ),
      ); // Add timeout


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List result = data['results'] ?? [];
        debugPrint('✅ $endPoint - Loaded ${result.length} movies');
        return result.map((json) => Movie.fromJson(json)).toList();
      } 
      else{
      throw Exception("hello");
      }
    } catch (e) {
      
       final response = await http.get(
        Uri.parse(
          '${ApiServices.baseUrl}$endPoint?api_key=${ApiServices.apiKey}&language=en-US&page=1',
        ),
      ); // Add timeout

      debugPrint('📡 $endPoint - Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List result = data['results'] ?? [];
        debugPrint('✅ $endPoint - Loaded ${result.length} movies');
        return result.map((json) => Movie.fromJson(json)).toList();
      } else {
        debugPrint('❌ $endPoint - Failed with status: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('HTTP ${response.statusCode}');
      }
    }
    
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}${ApiServices.search}?api_key=${ApiServices.apiKey}&query=$query&language=en-US&page=1'),
      ).timeout(const Duration(seconds: 30));
      
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List result = data['results'] ?? [];
        return result.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load search results");
      }
    } catch (e) {
       final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}${ApiServices.search}?api_key=${ApiServices.apiKey}&query=$query&language=en-US&page=1'),
      ).timeout(const Duration(seconds: 30));
        if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List result = data['results'] ?? [];
        return result.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load search results");
      }

    }
  }
}