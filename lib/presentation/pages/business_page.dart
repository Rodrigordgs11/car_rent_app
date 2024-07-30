import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/data/sharedPreferences/prefs.dart';
import 'package:namer_app/presentation/bloc/statistic_bloc.dart';
import 'package:namer_app/presentation/bloc/statistic_event.dart';
import 'package:namer_app/presentation/bloc/statistic_state.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsSeller.dart';
import 'package:namer_app/presentation/items/bottomNavigationBarItemsUser.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  final Prefs _prefs = Prefs();
  int _selectedIndex = 0;
  String? _typeOfUser;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? typeOfUser = await _prefs.getSharedPref('typeOfUser');
    String? username = await _prefs.getSharedPref('username');
    setState(() {
      _typeOfUser = typeOfUser;
      _username = username;
      _selectedIndex = (typeOfUser == 'user') ? getSelectedIndexUser() : getSelectedIndexSeller();
      context.read<StatisticsBloc>().add(LoadStatistics(username: _username ?? ''));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
        title: const Text('Business Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state) {
                if (state is StatisticsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StatisticsLoaded) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blueAccent,
                                    child: const Icon(Icons.car_rental_outlined, color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('Rent Cars', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${state.numberOfCars}', style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ]
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blueAccent,
                                    child: const Icon(Icons.money_outlined, color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('Money earned', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${state.moneyEarned}€', style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is StatisticsError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _typeOfUser == null
        ? const Center(child: CircularProgressIndicator())
        : BottomNavigationBar(
            items: _typeOfUser == 'user' ? bottomNavigationBarItemsUser : bottomNavigationBarItemsSeller,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: _onItemTapped,
          ),
    );
  }
}