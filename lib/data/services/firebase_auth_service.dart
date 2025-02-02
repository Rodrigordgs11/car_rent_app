import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> createUser(String name, String username, String phoneNumber, String typeOfUser, String password) async {
    final user = {
      'name': name,
      'username': username,
      'phoneNumber': phoneNumber,
      'typeOfUser': typeOfUser,
      'password': password,
    };

    bool exists = await userExists(username);
    if (exists) {
      throw Exception('Username already exists');
    }

    DocumentReference docRef = await _firebaseFirestore.collection('users').add(user);
    DocumentSnapshot doc = await docRef.get();

    return doc.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final user = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (user.docs.isEmpty) {
      throw Exception('User not found');
    }

    return user.docs.first.data();
  }

  Future<bool> userExists(String username) async {
    final user = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (user.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
