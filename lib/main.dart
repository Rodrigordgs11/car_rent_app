import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/injection_container.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_event.dart';
import 'package:namer_app/presentation/pages/onboarding_page.dart';
import 'firebase_options.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjection();
  // createCarsInFirebase();
  // createUserFirebase();
  runApp(const MyApp());
}

// void createUserFirebase() {
//   // Code to create user in Firebase
//   FirebaseFirestore db = FirebaseFirestore.instance;

//   final users = [
//     {
//       'name': 'Rodrigo',
//       'username': 'rodrigo',
//       'password': 'rodrigo',
//     },
//   ];

//   users.forEach((user) {
//     db.collection('users').add(user);
//   });
// }
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CarBloc>()..add(LoadCars()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255),
            primary: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
        home: OnboardingPage(),
      ),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final LocalAuthentication myAuthentication;
  bool authState = false;

  @override
  void initState() {
    super.initState();
    myAuthentication = LocalAuthentication();
    _checkDeviceSupport();
  }

  Future<void> _checkDeviceSupport() async {
    bool isSupported = await myAuthentication.isDeviceSupported();
    setState(() {
      authState = isSupported;
    });
  }

  Future<void> authenticate() async {
    try {
      bool isAuthenticated = await myAuthentication.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingPage()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication Page')),
      body: Center(
        child: authState
            ? ElevatedButton(
                onPressed: authenticate,
                child: const Text('Authenticate'),
              )
            : const Text('Device does not support authentication'),
      ),
    );
  }
}