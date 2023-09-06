import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:readmore/readmore.dart';
import 'package:spacex/components/characteristics.dart';
import 'package:spacex/components/composition.dart';
import 'package:spacex/models/Planet.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanetDescPage extends StatelessWidget {
  final Planet planet;
  const PlanetDescPage({super.key, required this.planet});

  Future<void> _launchUrl(final _url) async {
    final uri = Uri.parse(_url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  padding: const EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(175, 51, 85, 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  )),
            ),
          ),
          title: const Text(
            "Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            _launchUrl(planet.wikiUrl);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 50,
            decoration: BoxDecoration(
                color: Color.fromRGBO(175, 51, 85, 1),
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.watch_later_outlined,
                  size: 22,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "more info.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ModelViewer(
                      src: planet.modelUrl,
                      ar: true,
                      autoPlay: true,
                      autoRotate: true,
                      alt: "A planet model",
                    )),
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    planet.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    planet.shortDescription,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'No. of moons',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(planet.numberOfMoon),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'days',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(planet.day),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  planet.description,
                  trimLines: 2,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[200],
                  ),
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[200],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TabBar(
                            unselectedLabelColor: Colors.black,
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            indicator: BoxDecoration(
                              color: Color.fromRGBO(175, 51, 85, 1.0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            tabs: const [
                              Tab(
                                text: "Characteristics",
                              ),
                              Tab(
                                text: "Composition",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Characteristics(
                                  physicalCharacteristics:
                                      planet.physicalCharacteristics),
                              Composition(CompositionList: planet.composition)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
