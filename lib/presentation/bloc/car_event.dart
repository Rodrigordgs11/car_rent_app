abstract class CarEvent {}

class LoadCars extends CarEvent {
  final String userType;
  final String username;

  LoadCars({required this.userType, required this.username});
}