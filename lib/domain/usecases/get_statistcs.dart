import 'package:namer_app/domain/repositories/statistics_repository.dart';

class GetStatistcs{
  final StatisticsRepository statistcsRepository;

  GetStatistcs(this.statistcsRepository);

  Future<int> getNumberOfCars(String username) async {
    return await statistcsRepository.fetchTotalOfCars(username);
  }

  Future<int> getMoneyEarned(String username) async {
    return await statistcsRepository.fetchMoneyEarned(username);
  }
}