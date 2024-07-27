import 'package:flutter/material.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/pages/auth/login_page.dart';
import 'package:namer_app/presentation/widgets/button_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Prefs _prefs = Prefs();
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
                      radius: 50,
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
    );
  }
}