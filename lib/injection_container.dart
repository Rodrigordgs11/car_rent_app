
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:namer_app/data/datasources/firebase_data_souce.dart';
import 'package:namer_app/data/repositories/car_repositoty_impl.dart';
import 'package:namer_app/data/services/firebase_car_service.dart';
import 'package:namer_app/domain/repositories/car_repository.dart';
import 'package:namer_app/domain/usecases/get_cars.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';

GetIt getIt = GetIt.instance;

void initInjection(){
  try{
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    getIt.registerLazySingleton<FirebaseDataSouce>(
            () => FirebaseDataSouce(firestore: getIt<FirebaseFirestore>())
    );
    getIt.registerLazySingleton<CarRepository>(
            () => CarRepositoryImpl(dataSouce: getIt<FirebaseDataSouce>())
    );
    getIt.registerLazySingleton<GetCars>(
            () => GetCars(getIt<CarRepository>())
    );
    getIt.registerLazySingleton<FirebaseCarService>(
            () => FirebaseCarService(repository: getIt<CarRepository>()),
    );
    getIt.registerFactory(() => CarBloc(getCars: getIt<GetCars>()));

  } catch (e){
    throw e;
  }
}