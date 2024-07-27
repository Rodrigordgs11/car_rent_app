import 'package:flutter/material.dart';
import 'package:namer_app/presentation/pages/profile_page.dart';

  var bottomNavigationBarItemsSeller = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void onItemTappedSeller(BuildContext context, int index) {
    if (index == 0) {
      // Ação para o item 0 do BottomNavigationBar (Home)
      print('Home');
    } else if (index == 1) {
      // Ação para o item 1 do BottomNavigationBar (Business)
      print('Business');
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }