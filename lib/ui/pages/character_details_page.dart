import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_event.dart';
import 'package:studio_ghibli_app/bloc/films/films_state.dart';
import 'package:studio_ghibli_app/bloc/species/species_bloc.dart';
import 'package:studio_ghibli_app/bloc/species/species_event.dart';
import 'package:studio_ghibli_app/bloc/species/species_state.dart';
import 'package:studio_ghibli_app/models/character.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';
import 'package:studio_ghibli_app/repository/species_repository.dart';
import 'package:studio_ghibli_app/ui/pages/film_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/species_details_page.dart';
import 'package:studio_ghibli_app/utils/color_parser.dart';

class CharacterDetailsPage extends StatelessWidget {
  final Character character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SpeciesBloc>(
          create: (context) => SpeciesBloc(
            speciesRepository: RepositoryProvider.of<SpeciesRepository>(context),
          )..add(LoadSpeciesDetailsByUrlEvent(character.species)),
        ),
        BlocProvider<FilmsBloc>(
          create: (context) => FilmsBloc(
            filmsRepository: RepositoryProvider.of<FilmsRepository>(context),
          )..add(LoadFilmsByUrlsEvent(character.films)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(character.name, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
          backgroundColor: Colors.black.withOpacity(0.5),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorParser.getColorFromString(character.hairColor), ColorParser.getColorFromString(character.eyeColor)]
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
        Text('Name: ${character.name}', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        const SizedBox(height: 10),
        Text('Gender: ${character.gender}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Age: ${character.age}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Eye color: ${character.eyeColor}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Hair color: ${character.hairColor}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        _buildSpeciesBlocBuilder(),
        const SizedBox(height: 5),
        _buildFilmsExpansionTile(context),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildSpeciesBlocBuilder() {
    return BlocBuilder<SpeciesBloc, SpeciesState>(
      builder: (context, state) {
        if (state is SpeciesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SpeciesDetailsLoadedState) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SpeciesDetailsPage(species: state.speciesDetails),
                ),
              );
            },
            child: Text('Species: ${state.speciesDetails.name}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
          );
        } else if (state is SpeciesErrorState) {
          return Text('Species: Error: ${state.message}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white));
        }
        return const SizedBox.shrink();
      },
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
