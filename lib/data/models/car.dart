class Car{
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;
  final String seller;

  Car({required this.model, required this.distance, required this.fuelCapacity, required this.pricePerHour, required this.seller});

  factory Car.fromDocument(doc){
    return Car(
      model: doc['model'],
      distance: doc['distance'],
      fuelCapacity: doc['fuelCapacity'],
      pricePerHour: doc['pricePerHour'],
      seller: doc['seller'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'model': model,
      'distance': distance,
      'fuelCapacity': fuelCapacity,
      'pricePerHour': pricePerHour,
      'seller': seller,
    };
  }
}