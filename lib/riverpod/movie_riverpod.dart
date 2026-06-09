import 'package:flutter/material.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/services/tmbd_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider =
    ChangeNotifierProvider<MovieProvider>((ref) {
  return MovieProvider();
});

class MovieProvider extends ChangeNotifier {
   final TmbdServices _tmbdServices = TmbdServices();

  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _searchResult = [];
  bool _isLoading = false;
  bool _isLoaded = false;
  String? _errorMessage;

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get searchResult => _searchResult;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

 Future<void> searchMovies(String query) async {
  if (query.isEmpty) {
    _searchResult = [];
    _errorMessage = null; // Clear error when search is cleared
    _isLoading = false; // Reset loading state
    notifyListeners();
    return;
  }
  
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();
  
  try {
    _searchResult = await _tmbdServices.searchMovies(query);
    _errorMessage = null;
  } catch (e) {
    _errorMessage = 'Failed to Search Movies';
    _searchResult = [];
    debugPrint("Search error: $e");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

// Add a dedicated method to clear search
void clearSearch() {
  _searchResult = [];
  _errorMessage = null;
  _isLoading = false;
  notifyListeners();
}

  Future<void> loadMovies() async {
      if (_isLoaded) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _nowPlayingMovies = await _tmbdServices.getNowPlayingMovies();
      _popularMovies = await _tmbdServices.getPopularMovies();
      _topRatedMovies = await _tmbdServices.getTopRatedMovies();
      _upcomingMovies = await _tmbdServices.getUpcomingMovies();

      _errorMessage = null;
        _isLoaded = true; 
    } catch (e) {
      debugPrint("ERROR: $e");
      _errorMessage =
          'Failed to load movies. Please check your internet connection';
    } 
      _isLoading = false;
      notifyListeners();
    
  }
}
