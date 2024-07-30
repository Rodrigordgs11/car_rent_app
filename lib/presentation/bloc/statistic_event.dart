abstract class StatisticsEvent {}

class LoadStatistics extends StatisticsEvent {
  final String username;

  LoadStatistics({required this.username});
}