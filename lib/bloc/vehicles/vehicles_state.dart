import 'package:studio_ghibli_app/models/vehicle.dart';

abstract class VehiclesState {}

class VehiclesInitialState extends VehiclesState {}

class VehiclesLoadingState extends VehiclesState {}

class VehiclesLoadedState extends VehiclesState {
  final List<Vehicle> vehicles;

  VehiclesLoadedState(this.vehicles);
}

class VehiclesDetailsLoadingState extends VehiclesState {}

class VehiclesDetailsLoadedState extends VehiclesState {
  final Vehicle vehicleDetails;

  VehiclesDetailsLoadedState(this.vehicleDetails);
}

class VehiclesErrorState extends VehiclesState {
  final String message;

  VehiclesErrorState(this.message);
}