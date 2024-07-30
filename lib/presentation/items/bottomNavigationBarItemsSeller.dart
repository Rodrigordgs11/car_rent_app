import 'package:flutter/material.dart';
import 'package:namer_app/presentation/pages/business_page.dart';
import 'package:namer_app/presentation/pages/car_list_screen.dart';
import 'package:namer_app/presentation/pages/profile_page.dart';

  int _selectedIndexSeller = 0;

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
      _selectedIndexSeller = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => CarListScreen()));
    } else if (index == 1) {
      _selectedIndexSeller = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessPage()));
    } else if (index == 2) {
      _selectedIndexSeller = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  int getSelectedIndexSeller() {
    return _selectedIndexSeller;
  }