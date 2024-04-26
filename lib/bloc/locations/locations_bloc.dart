import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_event.dart';
import 'package:studio_ghibli_app/bloc/locations/locations_state.dart';
import 'package:studio_ghibli_app/repository/locations_repository.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationsRepository locationsRepository;

  LocationsBloc({required this.locationsRepository}) : super(LocationsInitialState()) {
    on<LoadLocationsEvent>((event, emit) async {
      emit(LocationsLoadingState());
      try {
        final locations = await locationsRepository.fetchLocations();
        emit(LocationsLoadedState(locations));
      } catch (e) {
        emit(LocationsErrorState(e.toString()));
      }
    });

    on<LoadLocationsByIdsEvent>((event, emit) async {
      emit(LocationsLoadingState());
      try {
        final locations = await locationsRepository.fetchLocationsByIds(
            event.ids);
        emit(LocationsLoadedState(locations));
      } catch (e) {
        emit(LocationsErrorState(e.toString()));
      }
    });

    on<LoadLocationsByUrlsEvent>((event, emit) async {
      emit(LocationsLoadingState());
      try {
        final locations = await locationsRepository.fetchLocationsByUrls(
            event.urls);
        emit(LocationsLoadedState(locations));
      } catch (e) {
        emit(LocationsErrorState(e.toString()));
      }
    });

    on<LoadLocationDetailsByIdEvent>((event, emit) async {
      emit(LocationDetailsLoadingState());
      try {
        final locationDetails = await locationsRepository.fetchLocationDetails(
            event.locationId);
        emit(LocationDetailsLoadedState(locationDetails));
      } catch (e) {
        emit(LocationsErrorState(e.toString()));
      }
    });

    on<LoadLocationDetailsByUrlEvent>((event, emit) async {
      emit(LocationDetailsLoadingState());
      try {
        final locationDetails = await locationsRepository.fetchLocationByUrl(
            event.url);
        emit(LocationDetailsLoadedState(locationDetails));
      } catch (e) {
        emit(LocationsErrorState(e.toString()));
      }
    });
  }
}