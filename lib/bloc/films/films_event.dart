

abstract class FilmsEvent {}

class LoadFilmsEvent extends FilmsEvent {}

class LoadFilmDetailsByIdEvent extends FilmsEvent {
  final String filmId;

  LoadFilmDetailsByIdEvent(this.filmId);
}

class LoadFilmsByIdsEvent extends FilmsEvent {
  final List<String> ids;

  LoadFilmsByIdsEvent(this.ids);
}

class LoadFilmsByUrlsEvent extends FilmsEvent {
  final List<String> urls;

  LoadFilmsByUrlsEvent(this.urls);
}

class LoadFilmDetailsByUrlEvent extends FilmsEvent {
  final String url;

  LoadFilmDetailsByUrlEvent(this.url);
}