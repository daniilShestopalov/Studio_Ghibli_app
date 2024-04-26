

abstract class SpeciesEvent {}

class LoadSpeciesEvent extends SpeciesEvent {}

class LoadSpeciesDetailsByIdEvent extends SpeciesEvent {
  final String speciesId;

  LoadSpeciesDetailsByIdEvent(this.speciesId);
}

class LoadSpeciesByIdsEvent extends SpeciesEvent {
  final List<String> ids;

  LoadSpeciesByIdsEvent(this.ids);
}

class LoadSpeciesByUrlsEvent extends SpeciesEvent {
  final List<String> urls;

  LoadSpeciesByUrlsEvent(this.urls);
}

class LoadSpeciesDetailsByUrlEvent extends SpeciesEvent {
  final String url;

  LoadSpeciesDetailsByUrlEvent(this.url);
}