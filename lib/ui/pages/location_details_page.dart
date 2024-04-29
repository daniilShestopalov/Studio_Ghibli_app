import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_event.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_state.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_event.dart';
import 'package:studio_ghibli_app/bloc/films/films_state.dart';
import 'package:studio_ghibli_app/models/location.dart';
import 'package:studio_ghibli_app/repository/characters_repository.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';
import 'package:studio_ghibli_app/ui/pages/character_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/film_details_page.dart';

class LocationsDetailsPage extends StatelessWidget {
  final Location location;

  const LocationsDetailsPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersBloc>(
          create: (context) => CharactersBloc(
            charactersRepository: RepositoryProvider.of<CharactersRepository>(context),
          )..add(LoadCharactersByUrlsEvent(location.residents)),
        ),
        BlocProvider<FilmsBloc>(
          create: (context) => FilmsBloc(
            filmsRepository: RepositoryProvider.of<FilmsRepository>(context),
          )..add(LoadFilmsByUrlsEvent(location.films)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(location.name, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
          backgroundColor: const Color(0xFF1F8DB8),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        extendBodyBehindAppBar: true,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ghibli_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
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
              const SizedBox(height: 200, child: Center(child: Text(''))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCharacterDetails(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterDetails(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Name: ${location.name}', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        const SizedBox(height: 10),
        Text('Climate: ${location.climate}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Terrain: ${location.terrain}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Surface water: ${location.surfaceWater}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        _buildResidentsBlocBuilder(),
        const SizedBox(height: 5),
        _buildFilmsExpansionTile(context),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildResidentsBlocBuilder() {
    return ExpansionTile(
      title: const Text("Residents",  style: TextStyle(color: Colors.white),),
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
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailsPage(character: character),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is CharactersErrorState) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white),));
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _buildFilmsExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: const Text("Films", style: TextStyle(color: Colors.white)),
      children: [
        BlocBuilder<FilmsBloc, FilmsState>(
          builder: (context, state) {
            if (state is FilmsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FilmsLoadedState) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.films.length,
                itemBuilder: (context, index) {
                  final film = state.films[index];
                  return ListTile(
                    leading: Image.network(film.image, width: 100, fit: BoxFit.cover),
                    title: Text(film.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FilmDetailsPage(film: film)),
                      );
                    },
                    subtitle: Text(film.originalTitle, style: const TextStyle(color: Colors.white70)),
                  );
                },
              );
            } else if (state is FilmsErrorState) {
              return Text('Error: ${state.message}', style: const TextStyle(color: Colors.white));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
