import 'dart:convert';

import 'package:http/http.dart' as http;

import '../json_types.dart';
import 'api_keys.dart';

class IGDBApi {
  static String authToken = '';
  static Map<String, String>? headers = {};

  static String prevName = '';
  static JsonList prevResponse = [
    {'hi': "hi"}
  ];

  final protocol = 'https';
  final baseUrl = 'api.igdb.com/v4';

  IGDBApi() {
    login();
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
            'https://id.twitch.tv/oauth2/token?client_id=$igdbApiKey&client_secret=$igdbApiSecret&grant_type=client_credentials')
        as Json;
    authToken = response['access_token'];
    headers = {
      "Client-ID": igdbApiKey,
      "Authorization": 'Bearer $authToken',
    };
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
                'search "$name"; fields name, cover, first_release_date, summary; limit $limit;')
        as JsonList;
    prevResponse = response;
    return response;
  }

  Future<String> getCoverUrlFromJson(Json gameJson, {String? size="720p"}) async {
    return getCoverUrl(gameJson['cover'], size: size);
  }

  Future<String> getCoverUrl(int coverId, {String? size="720p"}) async {
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

  Future<Map<int, String>?> getCoverUrls(gamesList, {String? size="720p"}) async {
    if (authToken.isEmpty) {
      await login();
    }
    //print(gamesList);
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
      for (int id in coverIds) {
        queryInts.add(id);
        i++;

        if (i == 10) {
          queryStrings.add(intListToQueryString(queryInts));
          queryInts = [];
          i = 0;
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

  String intListToQueryString(List<dynamic> list) {
    return list.toString().replaceFirst("[", "(").replaceFirst("]", ")");
  }

  void test() async {
    print('testing');
    login();
    JsonList gamesList = await searchGames("Halo");
    //print(gamesList);
    print(getCoverUrls(gamesList));
    //getCoverUrl(gamesList[0]);
    //String coverUrl = await getCoverUrl(gamesList[0]);
    //print(coverUrl);
  }
}
