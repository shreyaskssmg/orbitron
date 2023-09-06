import 'package:flutter/material.dart';
import 'package:spacex/models/Star.dart';

// ignore: must_be_immutable
class StarTile extends StatelessWidget {
  final Star star;
  const StarTile({super.key, required this.star});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/image.png",
                        image: star.imageUrl),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          star.title,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            star.description,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 10,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
