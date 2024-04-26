import 'package:studio_ghibli_app/models/location.dart';

abstract class LocationsState {}

class LocationsInitialState extends LocationsState {}

class LocationsLoadingState extends LocationsState {}

class LocationsLoadedState extends LocationsState {
  final List<Location> locations;

  LocationsLoadedState(this.locations);
}

class LocationDetailsLoadingState extends LocationsState {}

class LocationDetailsLoadedState extends LocationsState {
  final Location locationDetails;

  LocationDetailsLoadedState(this.locationDetails);
}

class LocationsErrorState extends LocationsState {
  final String message;

  LocationsErrorState(this.message);
}