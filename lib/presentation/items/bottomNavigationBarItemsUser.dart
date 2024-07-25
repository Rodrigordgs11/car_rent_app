import 'package:flutter/material.dart';

var bottomNavigationBarItemsUser = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];

void onItemTappedUser(int index) {
  if (index == 0) {
    // Ação para o item 0 do BottomNavigationBar (Home)
    print('Home');
  } else if (index == 1) {
    // Ação para o item 1 do BottomNavigationBar (Profile)
    print('Profile');
  }
}