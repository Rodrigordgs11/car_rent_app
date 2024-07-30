import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/domain/usecases/get_statistcs.dart';
import 'package:namer_app/presentation/bloc/statistic_event.dart';
import 'package:namer_app/presentation/bloc/statistic_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final GetStatistcs getStatistics;

  StatisticsBloc({required this.getStatistics}) : super(StatisticsLoading()) {
    on<LoadStatistics>((event, emit) async {
      emit(StatisticsLoading());
      try {
        final totalOfCars = await getStatistics.getNumberOfCars(event.username);
        final moneyEarned = await getStatistics.getMoneyEarned(event.username);
        emit(StatisticsLoaded(totalOfCars, moneyEarned));
      } catch (e) {
        emit(StatisticsError(e.toString()));
      }
    });
  }
}