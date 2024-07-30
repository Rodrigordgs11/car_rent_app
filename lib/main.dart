import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/injection_container.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/statistic_bloc.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';
import 'package:namer_app/presentation/pages/onboarding_page.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Prefs _prefs = Prefs();

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
    return FutureBuilder<String?>(
      future: _prefs.getSharedPref('isLogged'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading preferences'));
        } else {
          final bool isLogged = snapshot.data == 'true';
          return FutureBuilder<String?>(
            future: _prefs.getSharedPref('isFirstTime'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading preferences'));
              } else {
                final bool isFirstTime = snapshot.data == 'true' || snapshot.data == null;

                Widget homeWidget;
                if (isLogged) {
                  homeWidget = CarListScreen();
                } else if (isFirstTime) {
                  homeWidget = OnboardingPage();
                } else {
                  homeWidget = LoginPage();
                }

                return MultiBlocProvider(
                  providers: [
                    BlocProvider<CarBloc>(
                      create: (context) => getIt<CarBloc>(),
                    ),
                    BlocProvider<StatisticsBloc>(
                      create: (context) => getIt<StatisticsBloc>(),
                    ),
                  ],
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: const Color.fromARGB(255, 255, 255, 255),
                        primary: Colors.blueAccent,
                      ),
                      useMaterial3: true,
                    ),
                    home: homeWidget,
                  ),
                );
              }
            },
          );
        }
      },
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