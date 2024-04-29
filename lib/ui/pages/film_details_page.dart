import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_event.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_state.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_bloc.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_event.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_state.dart';
import 'package:studio_ghibli_app/bloc/species/species_bloc.dart';
import 'package:studio_ghibli_app/bloc/species/species_event.dart';
import 'package:studio_ghibli_app/bloc/species/species_state.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_bloc.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_event.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_state.dart';
import 'package:studio_ghibli_app/models/film.dart';
import 'package:studio_ghibli_app/ui/pages/character_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/location_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/species_details_page.dart';
import 'package:studio_ghibli_app/ui/pages/vehicle_details_page.dart';

class FilmDetailsPage extends StatelessWidget {
  final Film film;

  const FilmDetailsPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    context.read<CharactersBloc>().add(LoadCharactersByUrlsEvent(film.people));
    context.read<SpeciesBloc>().add(LoadSpeciesByUrlsEvent(film.species));
    context.read<LocationsBloc>().add(LoadLocationsByUrlsEvent(film.locations));
    context.read<VehiclesBloc>().add(LoadVehiclesByUrlsEvent(film.vehicles));

    return Scaffold(
      appBar: AppBar(
        title: Text(film.title, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: _buildBody(context, theme),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme) {
    return Stack(
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
                child: _buildFilmDetails(context, theme)
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildFilmDetails(BuildContext context, ThemeData theme) {
    return Column(
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
        _buildCharacters(),
        const SizedBox(height: 5),
        _builtSpecies(),
        const SizedBox(height: 5),
        _builtLocations(),
        const SizedBox(height: 5),
        _builtVehicles(),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildCharacters() {
    return ExpansionTile(
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

  Widget _builtSpecies() {
    return ExpansionTile(
      title: const Text("Species",  style: TextStyle(color: Colors.white),),
      children: [
        BlocBuilder<SpeciesBloc, SpeciesState>(
          builder: (context, state) {
            if (state is SpeciesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SpeciesLoadedState) {
              if (state.species.isEmpty) {
                return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.species.length,
                  itemBuilder: (context, index) {
                    final species = state.species[index];
                    return ListTile(
                      title: Text(
                        species.name,
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
                        'Classification: ${species.classification}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SpeciesDetailsPage(species: species),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is SpeciesErrorState) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white),));
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _builtLocations() {
    return ExpansionTile(
      title: const Text("Locations",  style: TextStyle(color: Colors.white),),

      children: [
        BlocBuilder<LocationsBloc, LocationsState>(
          builder: (context, state) {
            if (state is LocationsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationsLoadedState) {
              if (state.locations.isEmpty) {
                return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final location = state.locations[index];
                    return ListTile(
                      title: Text(
                        location.name,
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
                        'Terrain: ${location.terrain}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsPage(location: location),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is LocationsErrorState) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white),));
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _builtVehicles() {
    return ExpansionTile(
      title: const Text("Vehicles",  style: TextStyle(color: Colors.white),),
      children: [
        BlocBuilder<VehiclesBloc, VehiclesState>(
          builder: (context, state) {
            if (state is VehiclesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VehiclesLoadedState) {
              if (state.vehicles.isEmpty) {
                return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = state.vehicles[index];
                    return ListTile(
                      title: Text(
                        vehicle.name,
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
                        'Vehicle class: ${vehicle.vehicleClass}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VehicleDetailsPage(vehicle: vehicle),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is VehiclesErrorState) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white),));
            }
            return Container();
          },
        ),
      ],
    );
  }
}