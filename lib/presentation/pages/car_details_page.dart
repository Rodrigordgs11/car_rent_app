import 'package:flutter/material.dart';
import 'package:namer_app/data/models/Car.dart';
import 'package:namer_app/presentation/pages/maps_details_page.dart';
import 'package:namer_app/presentation/widgets/car_card.dart';

class CarDetailsPage extends StatelessWidget{
  final Car car;

  const CarDetailsPage({Key? key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            Text(' Informations')
          ],
        ),
      ),
      body: Column(
        children: [
          CarCard(car: Car(model: car.model, distance: car.distance, fuelCapacity: car.fuelCapacity, pricePerHour: car.pricePerHour, seller: car.seller)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5,
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                        SizedBox(height: 10),
                        Text('Pedro Siuva', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('50000€', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapsDetailsPage(car: car)));
                    },
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/maps.png'),
                          fit: BoxFit.cover
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5,
                          )
                        ]
                      ),
                    ),
                  ),
                ) 
              ],
            )
          ),
          // Container(
          //   padding: EdgeInsets.all(20),
          //   child: Column(
          //     children: [
          //       MoreCard(car: Car(model: car.model, distance: car.distance, fuelCapacity: car.fuelCapacity, pricePerHour: car.pricePerHour)),
          //       SizedBox(height: 5,),
          //       MoreCard(car: Car(model: car.model, distance: car.distance, fuelCapacity: car.fuelCapacity, pricePerHour: car.pricePerHour)),
          //       SizedBox(height: 5,),
          //       MoreCard(car: Car(model: car.model, distance: car.distance, fuelCapacity: car.fuelCapacity, pricePerHour: car.pricePerHour)),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
  
}