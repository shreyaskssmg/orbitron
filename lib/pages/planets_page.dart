import 'package:flutter/material.dart';
import 'package:spacex/components/planets_tile.dart';
import 'package:spacex/components/star_tile.dart';
import 'package:spacex/models/Planet.dart';
import 'package:spacex/models/Star.dart';
import 'package:spacex/pages/planet_desc_page.dart';
import 'package:spacex/pages/star_desc_page.dart';

class PlanetPage extends StatefulWidget {
  final List<Planet> planet;
  final List<Star> star;
  PlanetPage({super.key, required this.planet, required this.star});

  @override
  State<PlanetPage> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Planets",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 360,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.planet.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlanetDescPage(planet: widget.planet[index]),
                      )),
                  child: PlanetTile(
                    planet: widget.planet[index],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Popular stars",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "✨",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.star.length,
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StarDescPage(star: widget.star[index]),
                        ),
                      ),
                      child: StarTile(
                        star: widget.star[index],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
