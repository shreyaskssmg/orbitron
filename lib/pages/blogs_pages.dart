import 'package:flutter/material.dart';
import 'package:spacex/components/news_tile.dart';
import 'package:spacex/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  final List<News> spaceNews;
  const NewsPage({super.key, required this.spaceNews});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<void> _launchUrl(final _url) async {
    final uri = Uri.parse(_url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: widget.spaceNews.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () => _launchUrl(widget.spaceNews[index].url),
                child: NewsTile(news: widget.spaceNews[index]))),
      ),
    );
  }
}
