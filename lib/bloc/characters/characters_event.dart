

abstract class CharactersEvent {}

class LoadCharactersEvent extends CharactersEvent {}

class LoadCharacterDetailsByIdEvent extends CharactersEvent {
  final String characterId;

  LoadCharacterDetailsByIdEvent(this.characterId);
}

class LoadCharactersByIdsEvent extends CharactersEvent {
  final List<String> ids;

  LoadCharactersByIdsEvent(this.ids);
}

class LoadCharactersByUrlsEvent extends CharactersEvent {
  final List<String> urls;

  LoadCharactersByUrlsEvent(this.urls);
}

class LoadCharacterDetailsByUrlEvent extends CharactersEvent {
  final String url;

  LoadCharacterDetailsByUrlEvent(this.url);
}