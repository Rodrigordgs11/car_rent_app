import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/data/models/Car.dart';

class FirebaseDataSouce{  
  final FirebaseFirestore firestore;

  FirebaseDataSouce({ required this.firestore });

  Future<List<Car>> getCars() async {
    final cars = await firestore.collection('cars').get();
    return cars.docs.map((doc) => Car.fromDocument(doc)).toList();
  }

  Future<List<Car>> getCarsBySeller(String username) async {
    final cars = await firestore.collection('cars').where('seller', isEqualTo: username).get();
    return cars.docs.map((doc) => Car.fromDocument(doc)).toList();
  }
} 