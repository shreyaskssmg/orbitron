import 'package:flutter/material.dart';
import 'package:spacex/models/Planet.dart';

class CharacteristicsCard extends StatelessWidget {
  final String title;
  final String value;
  CharacteristicsCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.red[100], borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Text(
              "$title : ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
