import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createUser(String name, String username, String password) async {
    final user = {
      'name': name,
      'username': username,
      'password': password,
    };

    await _firebaseFirestore.collection('users').add(user);
  }

  Future<bool> getUser(String username, String password) async {
    final user = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (user.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
