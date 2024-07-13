import 'package:namer_app/data/models/Car.dart';

abstract class CarRepository {
  Future<List<Car>> fetchCars();
}