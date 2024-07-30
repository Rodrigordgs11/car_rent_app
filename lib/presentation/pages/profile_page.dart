import 'package:flutter/material.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsSeller.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsUser.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'package:namer_app/presentation/widgets/button_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final Prefs _prefs = Prefs();
  int _selectedIndex = 0;
  String? _typeOfUser;

  @override
  void initState() {
    super.initState();
    _loadUserType();
    if (_typeOfUser == 'user') {
      _selectedIndex = getSelectedIndexUser();
    } else {
      _selectedIndex = getSelectedIndexSeller();
    }
  }

  Future<void> _loadUserType() async {
    String? typeOfUser = await _prefs.getSharedPref('typeOfUser');
    setState(() {
      _typeOfUser = typeOfUser;
    });
  }

  void _onItemTapped(int index) {
    if (_typeOfUser == 'user') {
      onItemTappedUser(context, index);
    } else {
      onItemTappedSeller(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<String?>(
        future: Prefs().getSharedPref('username'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final username = snapshot.data ?? 'No username found';

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, route)
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(180, 42),
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      child: Text('Edit Profile'),
                    ),
                    SizedBox(height: 40),
                    ButtonProfile(
                      icon: Icons.settings_outlined, 
                      title: 'Settings', 
                      onPressed: () {
                        // Navigator.push(context, route)
                      }
                    ),
                    SizedBox(height: 5),
                    ButtonProfile(
                      icon: Icons.language_outlined, 
                      title: 'Language',
                      onPressed: () {
                        // Navigator.push(context, route)
                      }
                    ),  
                    SizedBox(height: 5),
                    ButtonProfile(
                      icon: Icons.logout_outlined, 
                      title: 'Logout',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false);
                        _prefs.setSharedPref('isLogged', false.toString());
                        _prefs.setSharedPref('typeOfUser', '');
                        _prefs.setSharedPref('username', '');
                      },
                    ),         
                  ],
                ),
              ),
            );
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