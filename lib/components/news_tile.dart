import 'package:flutter/material.dart';
import 'package:spacex/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatelessWidget {
  final News news;
  const NewsTile({super.key, required this.news});

  Future<void> _launchUrl(final url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "can't launch the url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "assets/images/image.png",
                      alignment: Alignment.center,
                      image: news.imageUrl,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/space.jpg"),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        news.summary,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.grey.shade100, fontSize: 12),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
