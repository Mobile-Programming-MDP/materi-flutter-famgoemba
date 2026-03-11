import 'package:film/models/movie.dart';
import 'package:film/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as prefs;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ApiService apiService = ApiService();

  List<Movie> _favoriteMovies = [];

  Future<void> cekFavorite() async {
    final dataMovies = await apiService.getAllMovies();
    final List<Movie> moviesList = dataMovies
        .map((movie) => Movie.fromJson(movie))
        .toList();
    prefs.SharedPreferences.getInstance().then((prefs) {
      List<String> favoriteMovies = prefs.getStringList('favoriteMovies') ?? [];
      setState(() {
        _favoriteMovies = moviesList
            .where((movie) => favoriteMovies.contains(movie.id.toString()))
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    cekFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Text(
            'Favorite Movies',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = _favoriteMovies[index];
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                  width: 50,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
              );
            },
          ),
        ],
      ),
    );
  }
}
