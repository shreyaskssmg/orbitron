import 'package:flutter/material.dart';
import 'package:spacex/models/APOD.dart';

class APODPage extends StatefulWidget {
  final Apod apod;
  APODPage({super.key, required this.apod});

  @override
  State<APODPage> createState() => _APODPageState();
}

class _APODPageState extends State<APODPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/image.png",
                    alignment: Alignment.center,
                    placeholderCacheHeight: 1200,
                    placeholderCacheWidth: 1200,
                    image: widget.apod.url),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              widget.apod.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              textAlign: TextAlign.justify,
              widget.apod.explanation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
