import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_state.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'package:namer_app/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
  final Prefs _prefs = Prefs();

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
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              _prefs.setSharedPref('isLogged', false.toString());
              _prefs.setSharedPref('typeOfUser', '');
              _prefs.setSharedPref('username', '');
            },
          )
        ],
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state){
          if(state is CarsLoading){
            return  Center(child: CircularProgressIndicator(),);
          }
          else if(state is CarLoaded){
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) => CarCard(car: state.cars[index],)
            );
          }
          else if(state is CarError){
            return Center(child: Text(state.message),);
          }
          else{
            return Center(child: Text('Something went wrong'),);
          }
        },
      ),
    );
  }
}