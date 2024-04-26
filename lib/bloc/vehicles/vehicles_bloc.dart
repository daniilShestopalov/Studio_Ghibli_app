import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_event.dart';
import 'package:studio_ghibli_app/bloc/vehicles/vehicles_state.dart';
import 'package:studio_ghibli_app/repository/vehicles_repository.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final VehiclesRepository vehiclesRepository;

  VehiclesBloc({required this.vehiclesRepository}) : super(VehiclesInitialState()) {
    on<LoadVehiclesEvent>((event, emit) async {
      emit(VehiclesLoadingState());
      try {
        final vehicles = await vehiclesRepository.fetchVehicles();
        emit(VehiclesLoadedState(vehicles));
      } catch (e) {
        emit(VehiclesErrorState(e.toString()));
      }
    });

    on<LoadVehiclesByIdsEvent>((event, emit) async {
      emit(VehiclesLoadingState());
      try {
        final vehicles = await vehiclesRepository.fetchVehiclesByIds(
            event.ids);
        emit(VehiclesLoadedState(vehicles));
      } catch (e) {
        emit(VehiclesErrorState(e.toString()));
      }
    });

    on<LoadVehiclesByUrlsEvent>((event, emit) async {
      emit(VehiclesLoadingState());
      try {
        final vehicles = await vehiclesRepository.fetchVehiclesByUrls(
            event.urls);
        emit(VehiclesLoadedState(vehicles));
      } catch (e) {
        emit(VehiclesErrorState(e.toString()));
      }
    });

    on<LoadVehicleDetailsByIdEvent>((event, emit) async {
      emit(VehiclesDetailsLoadingState());
      try {
        final vehicleDetails = await vehiclesRepository.fetchVehicleDetails(
            event.vehicleId);
        emit(VehiclesDetailsLoadedState(vehicleDetails));
      } catch (e) {
        emit(VehiclesErrorState(e.toString()));
      }
    });

    on<LoadVehicleDetailsByUrlEvent>((event, emit) async {
      emit(VehiclesDetailsLoadingState());
      try {
        final vehicleDetails = await vehiclesRepository.fetchVehicleByUrl(
            event.url);
        emit(VehiclesDetailsLoadedState(vehicleDetails));
      } catch (e) {
        emit(VehiclesErrorState(e.toString()));
      }
    });
  }
}