import 'package:studio_ghibli_app/models/film.dart';

abstract class FilmsState {}

class FilmsInitialState extends FilmsState {}

class FilmsLoadingState extends FilmsState {}

class FilmsLoadedState extends FilmsState {
  final List<Film> films;

  FilmsLoadedState(this.films);
}

class FilmDetailsLoadingState extends FilmsState {}

class FilmDetailsLoadedState extends FilmsState {
  final Film filmDetails;

  FilmDetailsLoadedState(this.filmDetails);
}


class FilmsErrorState extends FilmsState {
  final String message;

  FilmsErrorState(this.message);
}
