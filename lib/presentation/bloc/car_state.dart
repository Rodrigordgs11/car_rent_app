import 'package:namer_app/data/models/Car.dart';

abstract class CarState {}

class CarsLoading extends CarState {}

class CarLoaded extends CarState {
  final List<Car> cars;

  CarLoaded(this.cars);
}

class CarError extends CarState {
  final String message;

  CarError(this.message);
}