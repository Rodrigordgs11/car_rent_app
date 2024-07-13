//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/injection_container.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_event.dart';
import 'package:namer_app/presentation/pages/onboarding_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjection();
  //createCarsInFirebase();
  runApp(const MyApp());
}

// void createCarsInFirebase(){
//   // Code to create cars in Firebase
//   FirebaseFirestore db = FirebaseFirestore.instance;

//   final cars = [
//     {
//       'model': 'Toyota Corolla',
//       'distance': 1000.0,
//       'fuelCapacity': 50.0,
//       'pricePerHour': 10.0
//     },
//     {
//       'model': 'Honda Civic',
//       'distance': 1200.0,
//       'fuelCapacity': 60.0,
//       'pricePerHour': 12.0
//     },
//     {
//       'model': 'Hyundai Elantra',
//       'distance': 1100.0,
//       'fuelCapacity': 55.0,
//       'pricePerHour': 11.0
//     },
//     {
//       'model': 'Ford Focus',
//       'distance': 1300.0,
//       'fuelCapacity': 65.0,
//       'pricePerHour': 13.0
//     },
//     {
//       'model': 'Chevrolet Cruze',
//       'distance': 1400.0,
//       'fuelCapacity': 70.0,
//       'pricePerHour': 14.0
//     }
//   ];

//   cars.forEach((car) {
//     db.collection('cars').add(car);
//   }); 
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CarBloc>()..add(LoadCars()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: OnboardingPage(),
      ),
    );
  }
}