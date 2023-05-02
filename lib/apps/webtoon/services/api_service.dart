import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    try {
      final response = await http.get(url);
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final webtoonInstance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(webtoonInstance);
      }
      return webtoonInstances;
    } catch (err) {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id,
      [http.Client? client]) async {
    client ??= http.Client();

    try {
      final response = await client.get(Uri.parse('$baseUrl/$id'));
      return WebtoonDetailModel.fromJson(jsonDecode(response.body));
    } catch (err) {
      throw Exception();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    List<WebtoonEpisodeModel> episodeInstances = [];
    try {
      final response = await http.get(url);
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    } catch (err) {
      throw Error();
    }
  }
}
