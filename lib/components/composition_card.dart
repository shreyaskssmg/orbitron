import 'package:flutter/material.dart';

class CompositionCard extends StatelessWidget {
  final String composition;
  CompositionCard({super.key, required this.composition});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.red[100], borderRadius: BorderRadius.circular(18)),
        child: Text(
          composition,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
