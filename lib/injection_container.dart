
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:namer_app/data/datasources/firebase_data_souce.dart';
import 'package:namer_app/data/datasources/firebase_data_source_statistics.dart';
import 'package:namer_app/data/repositories/car_repositoty_impl.dart';
import 'package:namer_app/data/repositories/statistics_repository_impl.dart';
import 'package:namer_app/data/services/firebase_car_service.dart';
import 'package:namer_app/domain/repositories/car_repository.dart';
import 'package:namer_app/domain/repositories/statistics_repository.dart';
import 'package:namer_app/domain/usecases/get_cars.dart';
import 'package:namer_app/domain/usecases/get_statistcs.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/statistic_bloc.dart';
import 'package:namer_app/presentation/bloc/statistic_state.dart';

GetIt getIt = GetIt.instance;

void initInjection(){
  try{
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    getIt.registerLazySingleton<FirebaseDataSouce>(
            () => FirebaseDataSouce(firestore: getIt<FirebaseFirestore>())
    );
    getIt.registerLazySingleton<FirebaseDataSourceStatistics>(
            () => FirebaseDataSourceStatistics(firestore: getIt<FirebaseFirestore>())
    );
    getIt.registerLazySingleton<CarRepository>(
            () => CarRepositoryImpl(dataSouce: getIt<FirebaseDataSouce>())
    );
    getIt.registerLazySingleton<StatisticsRepository>(
            () => StatisticsRepositoryImpl(dataSouce: getIt<FirebaseDataSourceStatistics>())
    );
    getIt.registerLazySingleton<GetCars>(
            () => GetCars(getIt<CarRepository>())
    );
    getIt.registerLazySingleton<GetStatistcs>(
            () => GetStatistcs(getIt<StatisticsRepository>())
    );
    getIt.registerLazySingleton<FirebaseCarService>(
            () => FirebaseCarService(repository: getIt<CarRepository>()),
    );
    getIt.registerFactory(() => CarBloc(getCars: getIt<GetCars>()));
    getIt.registerFactory(() => StatisticsBloc(getStatistics: getIt<GetStatistcs>()));

  } catch (e){
    throw e;
  }
}