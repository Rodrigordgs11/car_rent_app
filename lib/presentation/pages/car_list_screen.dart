import 'package:flutter/material.dart';
import 'package:namer_app/data/models/Car.dart';
import 'package:namer_app/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
  final List<Car> cars = [
    Car(model: 'Audi A4', distance: 100,fuelCapacity: 50, pricePerHour: 10),
    Car(model: 'BMW X5', distance: 200,fuelCapacity: 60, pricePerHour: 20),
    Car(model: 'Mercedes C200', distance: 150,fuelCapacity: 55, pricePerHour: 15),
    Car(model: 'Toyota Corolla', distance: 120,fuelCapacity: 45, pricePerHour: 12),
    Car(model: 'Honda Civic', distance: 110,fuelCapacity: 40, pricePerHour: 11),
    Car(model: 'Ford Mustang', distance: 180,fuelCapacity: 65, pricePerHour: 18),
    Car(model: 'Chevrolet Camaro', distance: 170,fuelCapacity: 70, pricePerHour: 17),
    Car(model: 'Nissan Altima', distance: 130,fuelCapacity: 50, pricePerHour: 13),
    Car(model: 'Hyundai Sonata', distance: 140,fuelCapacity: 55, pricePerHour: 14),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return CarCard(car: cars[index]);
        },
      ),
    );
  }
}