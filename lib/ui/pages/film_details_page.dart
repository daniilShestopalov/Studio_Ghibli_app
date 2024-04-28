import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_event.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_state.dart';
import 'package:studio_ghibli_app/models/character.dart';
import 'package:studio_ghibli_app/models/film.dart';
import 'package:studio_ghibli_app/repository/characters_repository.dart';

class FilmDetailsPage extends StatelessWidget {
  final Film film;

  const FilmDetailsPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final charactersRepository = RepositoryProvider.of<CharactersRepository>(context);
    context.read<CharactersBloc>().add(LoadCharactersByUrlsEvent(film.people));

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
                      ExpansionTile(
                        title: const Text("Characters",  style: TextStyle(color: Colors.white),),
                        children: [
                          BlocBuilder<CharactersBloc, CharactersState>(
                            builder: (context, state) {
                              if (state is CharactersLoadingState) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is CharactersLoadedState) {
                                if (state.characters.isEmpty) {
                                  return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
                                }
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.characters.length,
                                    itemBuilder: (context, index) {
                                      final character = state.characters[index];
                                      return ListTile(
                                        title: Text(
                                          character.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                offset: const Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black.withOpacity(0.75),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Age: ${character.age}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        onTap: () {
                                          // TODO: Действие при нажатии - пока пусто, в будущем переход на страницу персонажа
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else if (state is CharactersErrorState) {
                                return Center(child: Text('Error: ${state.message}'));
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
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

class PlaceholderCharacterPage extends StatelessWidget {
  final Character character;

  const PlaceholderCharacterPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // Просто временный экран, пока вы не создадите реальный экран для персонажа
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Center(
        child: Text('Details for ${character.name}'),
      ),
    );
  }
}
