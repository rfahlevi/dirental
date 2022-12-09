import 'package:dirental/account_page.dart';
import 'package:dirental/booking_page.dart';
import 'package:dirental/custom_lib/theme.dart';
import 'package:dirental/data_booking_page.dart';
import 'package:dirental/data_page.dart';
import 'package:dirental/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedNavbar = 0;
  String? merkKendaraan;
  String? nopolKendaraan;
  String? transmisiKendaraan;
  String? lamaSewa;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const DataBookingPage(),
    const DataPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lighBlackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedNavbar,
        selectedItemColor: blueColor,
        unselectedItemColor: blackColor,
        onTap: _changeSelectedNavbar,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Data Booking',
            icon: Icon(
              Icons.book_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Data',
            icon: Icon(
              Icons.data_array_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(
              Icons.person_outline,
            ),
          ),
        ],
      ),
      body: _pages[_selectedNavbar],
    );
  }
}
