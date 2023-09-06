// To parse this JSON data, do
//
//     final planet = planetFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Planet> planetFromJson(String str) =>
    List<Planet>.from(json.decode(str).map((x) => Planet.fromJson(x)));

class Planet {
  Planet({
    required this.physicalCharacteristics,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    required this.modelUrl,
    required this.wikiUrl,
    required this.numberOfMoon,
    required this.day,
    required this.composition,
  });

  PhysicalCharacteristics physicalCharacteristics;
  String title;
  String shortDescription;
  String description;
  String imageUrl;
  String modelUrl;
  String wikiUrl;
  String numberOfMoon;
  String day;
  List<String> composition;

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        physicalCharacteristics:
            PhysicalCharacteristics.fromJson(json["physical_characteristics"]),
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        imageUrl: json["image_url"],
        modelUrl: json["model_url"],
        wikiUrl: json["wiki_url"],
        numberOfMoon: json["number_of_moon"],
        day: json["day"],
        composition: List<String>.from(json["composition"].map((x) => x)),
      );
}

class PhysicalCharacteristics {
  PhysicalCharacteristics({
    required this.meanDiameter,
    required this.surfaceArea,
    required this.volume,
    required this.mass,
    required this.meanDensity,
    required this.surfaceGravity,
  });

  String meanDiameter;
  String surfaceArea;
  String volume;
  String mass;
  String meanDensity;
  String surfaceGravity;

  factory PhysicalCharacteristics.fromJson(Map<String, dynamic> json) =>
      PhysicalCharacteristics(
        meanDiameter: json["mean_diameter"],
        surfaceArea: json["surface_area"],
        volume: json["volume"],
        mass: json["mass"],
        meanDensity: json["mean_density"],
        surfaceGravity: json["surface_gravity"],
      );
}
