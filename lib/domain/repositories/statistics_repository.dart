abstract class StatisticsRepository {
  Future<int> fetchTotalOfCars(String username);
  Future<int> fetchMoneyEarned(String username);
}