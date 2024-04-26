import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';
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
    final FilmsRepository filmsRepository = FilmsRepository(apiClient: apiClient);

    return MaterialApp(
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
      home: RepositoryProvider<FilmsRepository>(
        create: (context) => filmsRepository,
        child: BlocProvider<FilmsBloc>(
          create: (context) => FilmsBloc(filmsRepository: filmsRepository),
          child: const FilmsPage(),
        ),
      ),
    );
  }
}

