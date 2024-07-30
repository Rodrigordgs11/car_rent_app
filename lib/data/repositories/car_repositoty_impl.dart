import 'package:namer_app/data/datasources/firebase_data_souce.dart';
import 'package:namer_app/data/models/Car.dart';
import 'package:namer_app/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseDataSouce dataSouce;

  CarRepositoryImpl({required this.dataSouce});

  @override
  Future<List<Car>> fetchCars() {
    return dataSouce.getCars();
  } 

  @override
  Future<List<Car>> fetchCarBySeller(String username) {
    return dataSouce.getCarsBySeller(username);
  }

  @override
  Future<void> addCar(Car car) {
    return dataSouce.addCar(car);
  }
}