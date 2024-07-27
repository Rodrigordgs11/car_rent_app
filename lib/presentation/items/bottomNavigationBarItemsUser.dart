import 'package:flutter/material.dart';
import 'package:namer_app/presentation/pages/profile_page.dart';

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
    // Ação para o item 0 do BottomNavigationBar (Home)
    print('Home');
  } else if (index == 1) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }
}