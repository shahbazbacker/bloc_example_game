import 'dart:convert';
import 'dart:developer';

import 'package:bloc_games/repository/models/genre_model.dart';
import 'package:bloc_games/repository/models/results_error.dart';
import 'package:bloc_games/utils/api_key.dart';
import 'package:http/http.dart' as http;

class GameService {
  GameService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.rawg.io/api',
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String baseUrl;

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{
      'key': apiKey,
    };

    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/$url').replace(queryParameters: queryParameters);
  }

  Future<List<Genre>> getGenres() async {
    final response = await _httpClient.get(
      getUrl(url: 'genres'),
    );
    log(getUrl(url: 'genres').toString());
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        log(json.decode(response.body).toString(), name: "Genre API RESPONSE");
        GenreModel genreModelData = genreModelFromJson(response.body);
        return genreModelData.genres;
      } else {
        throw ErrorEmptyResponse('There is no genres, the list is empty');
      }
    } else {
      throw ErrorGettingGames('Error getting genres');
    }
  }
}
