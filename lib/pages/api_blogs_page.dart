import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/components/my_drawer.dart';
import 'package:spacex/models/News.dart';
import 'package:spacex/models/News.dart';
import 'package:spacex/models/News.dart';
import 'package:spacex/pages/blogs_pages.dart';

class ApiBlogsPage extends StatefulWidget {
  final String title;
  final String image_url;
  final String email;
  const ApiBlogsPage(
      {super.key,
      required this.title,
      required this.image_url,
      required this.email});

  @override
  State<ApiBlogsPage> createState() => _ApiBlogsPageState();
}

class _ApiBlogsPageState extends State<ApiBlogsPage> {
  List<News> spaceNews = [];

  Future<List<News>> _getNews() async {
    List<dynamic> news = [];

    final url = "https://api.spaceflightnewsapi.net/v3/blogs?_limit=15";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String jsondata = response.body;
      news = jsonDecode(jsondata);

      for (Map<String, dynamic> index in news) {
        spaceNews.add(News.fromJson(index));
      }
    }

    return spaceNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: Builder(
            builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: (() => Scaffold.of(context).openDrawer()),
                )),
        title: Text(
          "Blogs",
          style: TextStyle(fontSize: 18),
        ),
      ),
      drawer: MyDrawer(
          title: widget.title,
          image_url: widget.image_url,
          email: widget.email),
      body: FutureBuilder(
        future: _getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            List<News> spaceXNews = snapshot.data!;
            return NewsPage(
              spaceNews: spaceXNews,
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red[300],
            ),
          );
        },
      ),
    );
  }
}
