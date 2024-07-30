import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSourceStatistics{
  final FirebaseFirestore firestore;

  FirebaseDataSourceStatistics({ required this.firestore });

  Future<int> fetchNumberOfCars(String username) async {
    final statistics = await firestore.collection('cars').where('seller', isEqualTo: username).get();
    return statistics.docs.length;
  }

  Future<int> fetchMoneyEarned(String username) async {
    final statistics = await firestore.collection('cars').where('seller', isEqualTo: username).get();
    int total = 0;
    for (var doc in statistics.docs) {
      total += (doc['pricePerHour'] as double).toInt();
    }
    return total;
  }
}