import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_event.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_state.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_event.dart';
import 'package:studio_ghibli_app/bloc/films/films_state.dart';
import 'package:studio_ghibli_app/models/vehicle.dart';
import 'package:studio_ghibli_app/repository/characters_repository.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';
import 'package:studio_ghibli_app/ui/pages/character_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/film_details_page.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailsPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersBloc>(
          create: (context) => CharactersBloc(
            charactersRepository: RepositoryProvider.of<CharactersRepository>(context),
          )..add(LoadCharacterDetailsByUrlEvent(vehicle.pilot)),
        ),
        BlocProvider<FilmsBloc>(
          create: (context) => FilmsBloc(
            filmsRepository: RepositoryProvider.of<FilmsRepository>(context),
          )..add(LoadFilmsByUrlsEvent(vehicle.films)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(vehicle.name, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
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
        Text('Name: ${vehicle.name}', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        const SizedBox(height: 10),
        Text('Vehicle class: ${vehicle.vehicleClass}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Length: ${vehicle.length}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
        const SizedBox(height: 5),
        Text('Description:', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        Text(vehicle.description, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
        _buildPilotBlocBuilder(),
        const SizedBox(height: 5),
        _buildFilmsExpansionTile(context),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildPilotBlocBuilder() {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state is CharacterDetailsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CharacterDetailsLoadedState) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CharacterDetailsPage(character: state.characterDetails),
                ),
              );
            },
            child: Text('Pilot: ${state.characterDetails.name}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
          );
        } else if (state is CharactersErrorState) {
          return Text('Pilot: Error: ${state.message}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white));
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
