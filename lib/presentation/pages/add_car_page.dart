import 'package:flutter/material.dart';
import 'package:namer_app/data/models/Car.dart';
import 'package:namer_app/data/services/firebase_car_service.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelCapacityController = TextEditingController();
  final TextEditingController _pricePerHourController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final FirebaseCarService _carService = FirebaseCarService();
  final Prefs _prefs = Prefs();

  @override
  void dispose() {
    _modelController.dispose();
    _distanceController.dispose();
    _fuelCapacityController.dispose();
    _pricePerHourController.dispose();
    _sellerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rent Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _distanceController,
                decoration: InputDecoration(
                  labelText: 'Distance (km)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the distance';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _fuelCapacityController,
                decoration: InputDecoration(
                  labelText: 'Fuel Capacity (liters)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fuel capacity';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _pricePerHourController,
                decoration: const InputDecoration(
                  labelText: 'Price per Hour',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price per hour';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String model = _modelController.text;
                    double distance = double.parse(_distanceController.text);
                    double fuelCapacity = double.parse(_fuelCapacityController.text);
                    double pricePerHour = double.parse(_pricePerHourController.text);
                    String? seller = await _prefs.getSharedPref('username');

                    if(model.isNotEmpty || !distance.isNaN || !fuelCapacity.isNaN || !pricePerHour.isNaN || seller?.isNotEmpty == true) {
                      await _carService.addCar(Car(seller: seller.toString(), model: model, distance: distance, fuelCapacity: fuelCapacity, pricePerHour: pricePerHour));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Car created successfully'), 
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CarListScreen()), (route) => false);
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}