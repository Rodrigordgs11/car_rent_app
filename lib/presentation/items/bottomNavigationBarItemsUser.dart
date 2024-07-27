import 'package:flutter/material.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';
import 'package:namer_app/presentation/pages/profile_page.dart';

int _selectedIndexUser = 0;

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

void onItemTappedUser(BuildContext context, int index) {
  if (index == 0) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CarListScreen()));
    _selectedIndexUser = index;
  } else if (index == 1) {
    _selectedIndexUser = index;
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }
}

int getSelectedIndexUser() {
  return _selectedIndexUser;
}