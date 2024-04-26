import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/species/species_event.dart';
import 'package:studio_ghibli_app/bloc/species/species_state.dart';
import 'package:studio_ghibli_app/repository/species_repository.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final SpeciesRepository speciesRepository;

  SpeciesBloc({required this.speciesRepository}) : super(SpeciesInitialState()) {
    on<LoadSpeciesEvent>((event, emit) async {
      emit(SpeciesLoadingState());
      try {
        final species = await speciesRepository.fetchSpecies();
        emit(SpeciesLoadedState(species));
      } catch (e) {
        emit(SpeciesErrorState(e.toString()));
      }
    });

    on<LoadSpeciesByIdsEvent>((event, emit) async {
      emit(SpeciesLoadingState());
      try {
        final species = await speciesRepository.fetchSpeciesByIds(
            event.ids);
        emit(SpeciesLoadedState(species));
      } catch (e) {
        emit(SpeciesErrorState(e.toString()));
      }
    });

    on<LoadSpeciesByUrlsEvent>((event, emit) async {
      emit(SpeciesLoadingState());
      try {
        final species = await speciesRepository.fetchSpeciesByUrls(
            event.urls);
        emit(SpeciesLoadedState(species));
      } catch (e) {
        emit(SpeciesErrorState(e.toString()));
      }
    });

    on<LoadSpeciesDetailsByIdEvent>((event, emit) async {
      emit(SpeciesDetailsLoadingState());
      try {
        final speciesDetails = await speciesRepository.fetchSpeciesDetails(
            event.speciesId);
        emit(SpeciesDetailsLoadedState(speciesDetails));
      } catch (e) {
        emit(SpeciesErrorState(e.toString()));
      }
    });

    on<LoadSpeciesDetailsByUrlEvent>((event, emit) async {
      emit(SpeciesDetailsLoadingState());
      try {
        final speciesDetails = await speciesRepository.fetchSpeciesByUrl(
            event.url);
        emit(SpeciesDetailsLoadedState(speciesDetails));
      } catch (e) {
        emit(SpeciesErrorState(e.toString()));
      }
    });
  }
}