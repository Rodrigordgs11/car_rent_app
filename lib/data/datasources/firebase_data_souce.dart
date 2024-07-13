import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/data/models/Car.dart';

class FirebaseDataSouce{  
  final FirebaseFirestore firestore;

  FirebaseDataSouce({ required this.firestore });

  Future<List<Car>> getCars() async {
    final cars = await firestore.collection('cars').get();
    return cars.docs.map((doc) => Car.fromDocument(doc)).toList();
  }
} 