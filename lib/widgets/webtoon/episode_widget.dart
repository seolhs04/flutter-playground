import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  final String webtoonId;
  final WebtoonEpisodeModel episode;

  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  onButtonTap() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.green,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(5, 5),
                color: Colors.black.withOpacity(0.5),
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
