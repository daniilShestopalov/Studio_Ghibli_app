import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/characters/characters_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_bloc.dart';
import 'package:studio_ghibli_app/bloc/species/species_bloc.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_bloc.dart';
import 'package:studio_ghibli_app/repository/characters_repository.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';
import 'package:studio_ghibli_app/repository/locations_repository.dart';
import 'package:studio_ghibli_app/repository/species_repository.dart';
import 'package:studio_ghibli_app/repository/vehicles_repository.dart';
import 'package:studio_ghibli_app/ui/pages/films_page.dart';
import 'package:studio_ghibli_app/utils/api_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final ApiClient apiClient = ApiClient();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FilmsRepository>(
          create: (context) => FilmsRepository(apiClient: apiClient),
        ),
        RepositoryProvider<CharactersRepository>(
          create: (context) => CharactersRepository(apiClient: apiClient),
        ),
        RepositoryProvider<LocationsRepository>(
            create: (context) => LocationsRepository(apiClient: apiClient)
        ),
        RepositoryProvider<VehiclesRepository>(
            create: (context) => VehiclesRepository(apiClient: apiClient)
        ),
        RepositoryProvider<SpeciesRepository>(
            create: (context) => SpeciesRepository(apiClient: apiClient)
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FilmsBloc>(
            create: (context) => FilmsBloc(filmsRepository: context.read<FilmsRepository>()),
          ),
          BlocProvider<CharactersBloc>(
            create: (context) => CharactersBloc(charactersRepository: context.read<CharactersRepository>()),
          ),
          BlocProvider<LocationsBloc>(
            create: (context) => LocationsBloc(locationsRepository: context.read<LocationsRepository>()),
          ),
          BlocProvider<SpeciesBloc>(
            create: (context) => SpeciesBloc(speciesRepository: context.read<SpeciesRepository>()),
          ),
          BlocProvider<VehiclesBloc>(
            create: (context) => VehiclesBloc(vehiclesRepository: context.read<VehiclesRepository>()),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Studio Ghibli app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF153A4F),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            home: const FilmsPage(),
        ),
      ),
    );
  }
}

