import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_state.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsSeller.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsUser.dart';
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
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    String? typeOfUser = await _prefs.getSharedPref('typeOfUser');
    setState(() {
      _typeOfUser = typeOfUser;
    });
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
        title: Text('Choose Your Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
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
      bottomNavigationBar: _typeOfUser == null
        ? Center(child: CircularProgressIndicator())
        : BottomNavigationBar(
            items: [
              if (_typeOfUser == 'user')
                ...bottomNavigationBarItemsUser
              else
                ...bottomNavigationBarItemsSeller
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: _onItemTapped,
          ),
    );
  }
}