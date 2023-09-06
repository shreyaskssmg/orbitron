import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: GNav(
          onTabChange: (value) => onTabChange!(value),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          padding: const EdgeInsets.all(12),
          color: Colors.grey[400],
          activeColor: Color.fromRGBO(175, 51, 85, 1.0),
          tabBackgroundColor: Colors.white,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: " home",
            ),
            GButton(
              icon: Icons.rocket_launch,
              text: " APOD",
            ),
            GButton(
              icon: Icons.newspaper,
              text: " blogs",
            ),
          ],
        ),
      ),
    );
  }
}
