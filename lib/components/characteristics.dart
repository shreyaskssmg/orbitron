import 'package:flutter/material.dart';
import 'package:spacex/components/characteristics_card.dart';
import 'package:spacex/models/Planet.dart';

class Characteristics extends StatelessWidget {
  final PhysicalCharacteristics physicalCharacteristics;
  Characteristics({super.key, required this.physicalCharacteristics});

  @override
  Widget build(BuildContext context) {
    final meanDiameter = physicalCharacteristics.meanDiameter;
    final surfaceArea = physicalCharacteristics.surfaceArea;
    final volume = physicalCharacteristics.volume;
    final mass = physicalCharacteristics.mass;
    final meanDensity = physicalCharacteristics.meanDensity;
    final surfaceGravity = physicalCharacteristics.surfaceGravity;
    List PCTitle = [
      ["mean diameter", meanDiameter],
      ["surface area", surfaceArea],
      ["volume", volume],
      ["mass", mass],
      ["mean density", meanDensity],
      ["surface gravity", surfaceGravity]
    ];
    return SizedBox(
        height: 170,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => CharacteristicsCard(
            title: PCTitle[index][0],
            value: PCTitle[index][1],
          ),
        ));
  }
}
