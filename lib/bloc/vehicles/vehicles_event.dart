

abstract class VehiclesEvent {}

class LoadVehiclesEvent extends VehiclesEvent {}

class LoadVehicleDetailsByIdEvent extends VehiclesEvent {
  final String vehicleId;

  LoadVehicleDetailsByIdEvent(this.vehicleId);
}

class LoadVehiclesByIdsEvent extends VehiclesEvent {
  final List<String> ids;

  LoadVehiclesByIdsEvent(this.ids);
}

class LoadVehiclesByUrlsEvent extends VehiclesEvent {
  final List<String> urls;

  LoadVehiclesByUrlsEvent(this.urls);
}

class LoadVehicleDetailsByUrlEvent extends VehiclesEvent {
  final String url;

  LoadVehicleDetailsByUrlEvent(this.url);
}