import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_event.dart';
import 'package:studio_ghibli_app/bloc/films/films_state.dart';
import 'package:studio_ghibli_app/ui/pages/film_details_page.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FilmsBloc>().add(LoadFilmsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
        backgroundColor: const Color(0xFF1F8DB8),
      ),
      body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ghibli_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BlocBuilder<FilmsBloc, FilmsState>(
              builder: (context, state) {
                if (state is FilmsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FilmsLoadedState) {
                  return ListView.builder(
                    itemCount: state.films.length,
                    itemBuilder: (context, index) {
                      final film = state.films[index];
                      return Container(
                        color: Colors.black.withOpacity(0.5),
                        child: ListTile(
                          leading: Image.network(film.image, width: 100, fit: BoxFit.cover),
                          title: Text(
                            film.title,
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FilmDetailsPage(film: film),
                              ),
                            );
                          },
                          subtitle: Text(
                            film.originalTitle,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FilmsErrorState) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Container();
              },
            ),
          ],
        ),

    );
  }
}
