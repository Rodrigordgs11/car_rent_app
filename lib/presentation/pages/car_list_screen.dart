import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/presentation/bloc/car_bloc.dart';
import 'package:namer_app/presentation/bloc/car_state.dart';
import 'package:namer_app/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state){
          if(state is CarsLoading){
            return  Center(child: CircularProgressIndicator(),);
          }
          else if(state is CarLoaded){
            return ListView.builder(
              itemCount: state.cars.length,
              itemBuilder: (context, index) => CarCard(car: state.cars  [index],)
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