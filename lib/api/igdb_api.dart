import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;

import '../json_types.dart';

class IGDBApi {
  static String authToken = '';
  static Map<String, String>? headers = {};

  static String prevName = '';
  static JsonList prevResponse = [
    {'hi': "hi"}
  ];
  static JsonList? topGames; // calls once and never again (hopefully)

  final protocol = 'https';
  final baseUrl = 'api.igdb.com/v4';

  static Map<int, String> platforms = <int, String>{};

  IGDBApi() {
    login();
    definePlatforms();
  }

  Future<Object> get(String uri, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(uri), headers: headers);
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      //print('${uri}\n${response.statusCode}');
      throw const FormatException('Unable to reach IGDB');
    }
  }

  Future<Object> post(String uri,
      {Map<String, String>? headers, String body = ''}) async {
    final response =
        await http.post(Uri.parse(uri), headers: headers, body: body);
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print('$uri\n${response.statusCode}\n${response.body}');
      throw const FormatException('Unable to reach IGDB');
    }
  }

  Future<void> login() async {
    Json response = await post(
            'https://id.twitch.tv/oauth2/token?client_id=${Settings.getValue<String>('APIKey', defaultValue: '')}&client_secret=${Settings.getValue<String>('APISecret', defaultValue: '')}&grant_type=client_credentials')
        as Json;
    authToken = response['access_token'];
    headers = {
      "Client-ID": Settings.getValue<String>('APIKey', defaultValue: '').toString(),
      "Authorization": 'Bearer $authToken',
    };
  }

  Future<void> definePlatforms() async {
    if (authToken.isEmpty) {
      await login();
    }

    JsonList response = await post('$protocol://$baseUrl/platforms',
        headers: headers,
        // anything here needs to probably be reflected
        body: 'fields name; sort id asc; limit 500;') as JsonList;

    for (var platform in response) {
      platforms[platform['id']] = platform['name'];
    }
  }

  Future<JsonList> searchGames(String name, {int limit = 10}) async {
    if (authToken.isEmpty) {
      await login();
    }
    if (name == prevName) {
      return prevResponse;
    } else {
      prevName = name;
    }

    JsonList response = await post('$protocol://$baseUrl/games',
            headers: headers,
            // anything here needs to probably be reflected
            body:
                'search "$name"; fields name, cover, first_release_date, summary, platforms; limit $limit;')
        as JsonList;
    //print(response);
    prevResponse = response;
    return response;
  }

  Future<JsonList> getTopGames() async {
    if (authToken.isEmpty) {
      await login();
    }
    if (topGames == null) {
      JsonList response = await post('$protocol://$baseUrl/games',
              headers: headers,
              // NEEDS TO HAVE THE SAME FIELDS AS SEARCHGAMES!!! plus the extra 2 obviously
              body:
                  'fields name, cover, first_release_date, summary, platforms, aggregated_rating, aggregated_rating_count; sort aggregated_rating desc; where aggregated_rating_count > 13; limit 75;')
          as JsonList;
      //print(response);
      topGames = response;
      return response;
    }
    return topGames as JsonList;
  }

  String? getPlatform(int num) {
    if (platforms.isEmpty) {
      return "";
    }
    return platforms[num];
  }

  Future<String> getCoverUrlFromJson(Json gameJson,
      {String? size = "720p"}) async {
    return getCoverUrl(gameJson['cover'], size: size);
  }

  Future<String> getCoverUrl(int coverId, {String? size = "720p"}) async {
    if (authToken.isEmpty) {
      await login();
    }
    //print(gameJson);
    //int coverId = gameJson['cover'];
    //print(coverId);
    //print(headers);
    JsonList response = await post('$protocol://$baseUrl/covers',
        headers: headers,
        body: 'fields game,url; where id=$coverId;') as JsonList;
    //print(response);
    String thumbUrl = '$protocol:${response[0]["url"]}';
    thumbUrl = thumbUrl.replaceFirst("t_thumb", "t_$size");
    return thumbUrl;
  }

  Future<Map<int, String>?> getCoverUrls(gamesList,
      {String? size = "720p"}) async {
    if (authToken.isEmpty) {
      await login();
    }
    //print(gamesList);
    //print(gamesList.length);
    //print(gamesList.runtimeType);
    List<dynamic> coverIds = [];
    try {
      // oh my god im so tired of debugging this
      coverIds = gamesList.map((item) => item['cover']).toList();
    } catch (e) {
      coverIds = gamesList.map((item) => item.cover).toList();
    }
    if (coverIds.isNotEmpty) {
      //print(coverIds);

      List<int> queryInts = [];
      List<String> queryStrings = [];
      int i = 0;
      for (var id in coverIds) {
        //print(id.runtimeType);
        if (id.runtimeType == int) {
          // filters out nulls, or no covers
          queryInts.add(id);
          i++;

          if (i == 10) {
            queryStrings.add(intListToQueryString(queryInts));
            queryInts = [];
            i = 0;
          }
        }
      }
      if (queryInts.isNotEmpty) {
        queryStrings.add(intListToQueryString(queryInts)); // Add any remaining
      }

      List<JsonList> responses = [];
      for (String query in queryStrings) {
        responses.add(await post('$protocol://$baseUrl/covers',
            headers: headers,
            body: 'fields game,url; where id=$query;') as JsonList);
      }

      Map<int, String> coverUrls = <int, String>{};
      for (JsonList responseList in responses) {
        for (var response in responseList) {
          coverUrls[response["game"]] =
              '$protocol:${response['url'].toString().replaceFirst("t_thumb", "t_$size")}';
        }
      }
      //print(coverUrls);
      return coverUrls;
    } else {
      return null;
    }
  }

  Future<String?> getArtworkUrl(int igdbID, {String? size = "1080p"}) async {
    if (authToken.isEmpty) {
      await login();
    }

    JsonList response = await post('$protocol://$baseUrl/artworks',
        headers: headers,
        body: 'fields game, url; where game=($igdbID);') as JsonList;

    if (response.isNotEmpty) {
      String thumbUrl = '$protocol:${response[0]["url"]}';
      thumbUrl = thumbUrl.replaceFirst("t_thumb", "t_$size");
      return thumbUrl;
    } else {
      return null;
    }
  }

  String intListToQueryString(List<dynamic> list) {
    return list.toString().replaceFirst("[", "(").replaceFirst("]", ")");
  }

  Future<bool> test() async {
    try {
      //print('testing');
      if (authToken.isEmpty) {
        await login();
      }

      await post('$protocol://$baseUrl/games',
          headers: headers,)
      as JsonList;
      //print("test response $response");

      return true;
    } catch (e) {
      return false;
    }
  }
}
