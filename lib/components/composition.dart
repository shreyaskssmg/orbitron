import 'package:flutter/material.dart';
import 'package:spacex/components/composition_card.dart';

class Composition extends StatelessWidget {
  final List CompositionList;
  Composition({super.key, required this.CompositionList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: CompositionList.length,
        itemBuilder: (context, index) =>
            CompositionCard(composition: CompositionList[index]),
      ),
    );
  }
}
