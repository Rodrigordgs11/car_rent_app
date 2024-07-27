import 'package:namer_app/data/models/Car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCarService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Future<void> addCar(Car car) async {
    firestore.collection('cars').add(car.toMap());
  }
  
  Future<void> updateCar(Car car) async {
    // Update car in Firebase
  }
  
  Future<void> deleteCar(Car car) async {
    // Delete car from Firebase
  }
}