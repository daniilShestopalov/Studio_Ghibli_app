

abstract class LocationsEvent {}

class LoadLocationsEvent extends LocationsEvent {}

class LoadLocationDetailsByIdEvent extends LocationsEvent {
  final String locationId;

  LoadLocationDetailsByIdEvent(this.locationId);
}

class LoadLocationsByIdsEvent extends LocationsEvent {
  final List<String> ids;

  LoadLocationsByIdsEvent(this.ids);
}

class LoadLocationsByUrlsEvent extends LocationsEvent {
  final List<String> urls;

  LoadLocationsByUrlsEvent(this.urls);
}

class LoadLocationDetailsByUrlEvent extends LocationsEvent {
  final String url;

  LoadLocationDetailsByUrlEvent(this.url);
}