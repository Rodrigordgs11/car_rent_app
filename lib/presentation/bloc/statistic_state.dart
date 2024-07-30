abstract class StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final int numberOfCars;
  final int moneyEarned;

  StatisticsLoaded(this.numberOfCars, this.moneyEarned);
}

class StatisticsError extends StatisticsState {
  final String message;

  StatisticsError(this.message);
}