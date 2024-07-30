import 'package:namer_app/data/datasources/firebase_data_source_statistics.dart';
import 'package:namer_app/domain/repositories/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final FirebaseDataSourceStatistics dataSouce;

  StatisticsRepositoryImpl({required this.dataSouce});
  
  @override
  Future<int> fetchMoneyEarned(String username) {
    return dataSouce.fetchMoneyEarned(username);
  }
  
  @override
  Future<int> fetchTotalOfCars(String username) {
    return dataSouce.fetchNumberOfCars(username);
  }
}