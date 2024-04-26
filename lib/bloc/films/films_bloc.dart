import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/films/films_event.dart';
import 'package:studio_ghibli_app/bloc/films/films_state.dart';
import 'package:studio_ghibli_app/repository/films_repository.dart';

class FilmsBloc extends Bloc<FilmsEvent, FilmsState> {
  final FilmsRepository filmsRepository;

  FilmsBloc({required this.filmsRepository}) : super(FilmsInitialState()) {
    on<LoadFilmsEvent>((event, emit) async {
      emit(FilmsLoadingState());
      try {
        final films = await filmsRepository.fetchFilms();
        emit(FilmsLoadedState(films));
      } catch (e) {
        emit(FilmsErrorState(e.toString()));
      }
    });

    on<LoadFilmsByIdsEvent>((event, emit) async {
      emit(FilmsLoadingState());
      try {
        final films = await filmsRepository.fetchFilmsByIds(
            event.ids);
        emit(FilmsLoadedState(films));
      } catch (e) {
        emit(FilmsErrorState(e.toString()));
      }
    });

    on<LoadFilmsByUrlsEvent>((event, emit) async {
      emit(FilmsLoadingState());
      try {
        final films = await filmsRepository.fetchFilmsByUrls(
            event.urls);
        emit(FilmsLoadedState(films));
      } catch (e) {
        emit(FilmsErrorState(e.toString()));
      }
    });

    on<LoadFilmDetailsByIdEvent>((event, emit) async {
      emit(FilmDetailsLoadingState());
      try {
        final filmDetails = await filmsRepository.fetchFilmDetails(
            event.filmId);
        emit(FilmDetailsLoadedState(filmDetails));
      } catch (e) {
        emit(FilmsErrorState(e.toString()));
      }
    });

    on<LoadFilmDetailsByUrlEvent>((event, emit) async {
      emit(FilmDetailsLoadingState());
      try {
        final filmDetails = await filmsRepository.fetchFilmByUrl(
            event.url);
        emit(FilmDetailsLoadedState(filmDetails));
      } catch (e) {
        emit(FilmsErrorState(e.toString()));
      }
    });
  }
}