import 'package:studio_ghibli_app/models/species.dart';

abstract class SpeciesState {}

class SpeciesInitialState extends SpeciesState {}

class SpeciesLoadingState extends SpeciesState {}

class SpeciesLoadedState extends SpeciesState {
  final List<Species> species;

  SpeciesLoadedState(this.species);
}

class SpeciesDetailsLoadingState extends SpeciesState {}

class SpeciesDetailsLoadedState extends SpeciesState {
  final Species speciesDetails;

  SpeciesDetailsLoadedState(this.speciesDetails);
}

class SpeciesErrorState extends SpeciesState {
  final String message;

  SpeciesErrorState(this.message);
}