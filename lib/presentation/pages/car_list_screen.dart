import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_event.dart';
import 'package:namer_app/presentation/bloc/car_state.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsSeller.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsUser.dart';
import 'package:namer_app/presentation/pages/add_car_page.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'package:namer_app/presentation/widgets/car_card.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final Prefs _prefs = Prefs();
  int _selectedIndex = 0;
  String? _typeOfUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? typeOfUser = await _prefs.getSharedPref('typeOfUser');
    String? username = await _prefs.getSharedPref('username');
    setState(() {
      _typeOfUser = typeOfUser;
    });
    if (typeOfUser != null && username != null) {
      context.read<CarBloc>().add(LoadCars(userType: typeOfUser, username: username));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_typeOfUser == 'user') {
      onItemTappedUser(index);
    } else {
      onItemTappedSeller(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _typeOfUser == null
            ? Text('Loading...')
            : _typeOfUser == 'user'
                ? Text('Choose Your Car')
                : Text('Your Rent Cars'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
              _prefs.setSharedPref('isLogged', false.toString());
              _prefs.setSharedPref('typeOfUser', '');
              _prefs.setSharedPref('username', '');
            },
          ),
        ],
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CarLoaded) {
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) => CarCard(car: state.cars[index]),
            );
          } else if (state is CarError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: _typeOfUser == null
          ? Text('Loading...')
          : _typeOfUser != 'user'
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCarPage()));
                },
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(Icons.add),
              )
            : null,
      bottomNavigationBar: _typeOfUser == null
        ? Center(child: CircularProgressIndicator())
        : BottomNavigationBar(
            items: [
              if (_typeOfUser == 'user') ...bottomNavigationBarItemsUser else ...bottomNavigationBarItemsSeller
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: _onItemTapped,
          ),
    );
  }
}