import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex/components/my_drawer.dart';
import 'package:spacex/models/Planet.dart';
import 'package:flutter/material.dart';
import 'package:spacex/models/Star.dart';
import 'package:spacex/pages/planets_page.dart';

class ApiPlanetsPage extends StatefulWidget {
  final String title;
  final String image_url;
  final String email;
  const ApiPlanetsPage(
      {super.key,
      required this.title,
      required this.image_url,
      required this.email});

  @override
  State<ApiPlanetsPage> createState() => _ApiPlanetsPageState();
}

class _ApiPlanetsPageState extends State<ApiPlanetsPage> {
  Future<List<dynamic>> _getPlanetsData() async {
    List<Planet> AllPlanets = [];
    List<Star> AllStar = [];
    List<dynamic> jPlanets;
    List<dynamic> jStars;
    final pUrl = "https://space-x-api-six.vercel.app/planets";
    final sUrl = "https://space-x-api-six.vercel.app/stars";
    http.Response pResponse = await http.get(Uri.parse(pUrl));
    http.Response sResponse = await http.get(Uri.parse(sUrl));

    if (pResponse.statusCode == 200 && sResponse.statusCode == 200) {
      String pJsonData = pResponse.body;
      String sJsonData = sResponse.body;

      jPlanets = jsonDecode(pJsonData);
      jStars = jsonDecode(sJsonData);

      for (Map<String, dynamic> index in jPlanets) {
        AllPlanets.add(Planet.fromJson(index));
      }
      for (Map<String, dynamic> index in jStars) {
        AllStar.add(Star.fromJson(index));
      }
    }
    return [AllPlanets, AllStar];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: Builder(
            builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: (() => Scaffold.of(context).openDrawer()),
                )),
      ),
      drawer: MyDrawer(
          title: widget.title,
          image_url: widget.image_url,
          email: widget.email),
      body: FutureBuilder(
        future: _getPlanetsData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<dynamic> PlanetAndStar = snapshot.data!;
            List<Planet> Planets = PlanetAndStar[0];
            List<Star> Stars = PlanetAndStar[1];
            return PlanetPage(
              planet: Planets,
              star: Stars,
            );
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.red[300]),
          );
        },
      ),
    );
  }
}
