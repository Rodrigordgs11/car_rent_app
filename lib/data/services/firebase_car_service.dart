import 'package:namer_app/data/models/Car.dart';
import 'package:namer_app/domain/repositories/car_repository.dart';

class FirebaseCarService {
  final CarRepository repository;

  FirebaseCarService({required this.repository});

  Future<void> addCar(Car car) async {
    await repository.addCar(car);
  }

  Future<void> updateCar(Car car) async {
    // Update car in Firebase
  }

  Future<void> deleteCar(Car car) async {
    // Delete car from Firebase
  }
}