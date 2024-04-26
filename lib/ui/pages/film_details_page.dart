import 'package:flutter/material.dart';
import 'package:studio_ghibli_app/models/film.dart';

class FilmDetailsPage extends StatelessWidget {
  final Film film;

  const FilmDetailsPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(film.title, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: 'assets/placeholders/placeholder_image.png',
            image: film.movieBanner,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: kToolbarHeight + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 200,
                  child: Center(child: Text('')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Title: ${film.title}', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                      const SizedBox(height: 10),
                      Text('Original Title: ${film.originalTitle}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 5),
                      Text('Original Title Romanised: ${film.originalTitleRomanised}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      Text('Director: ${film.director}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 5),
                      Text('Producer: ${film.producer}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      Text('Release Date: ${film.releaseDate}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 5),
                      Text('Running Time: ${film.runningTime} minutes', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      Text('Score: ${film.rtScore}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 20),
                      Text('Description:', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                      Text(film.description, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
