import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_keys.dart';

typedef Json = Map<String, dynamic>;
typedef JsonList = List<dynamic>;

class IGDBApi {
  static String authToken = '';
  static Map<String, String>? headers = {};

  final protocol = 'https';
  final baseUrl = 'api.igdb.com/v4';

  Future<Object> get(String uri,
      {Map<String, String>? headers}) async {
    final response =
    await http.get(Uri.parse(uri), headers: headers);
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
      print('${uri}\n${response.statusCode}\n${response.body}');
      throw const FormatException('Unable to reach IGDB');
    }
  }

  Future<void> login() async {
    Json response = await post(
        'https://id.twitch.tv/oauth2/token?client_id=$igdbApiKey&client_secret=$igdbApiSecret&grant_type=client_credentials') as Json;
    authToken = response['access_token'];
    headers = {
      "Client-ID": igdbApiKey,
      "Authorization": 'Bearer $authToken',
    };
  }

  Future<JsonList> searchGames(String name) async {
    if (authToken.isEmpty) {
      await login();
    }
    JsonList response = await post('$protocol://$baseUrl/games',
        headers: headers,
        body: 'search "$name"; fields name, cover, first_release_date;') as JsonList;
    return response;
  }

  Future<String> getCoverUrl(Json gameJson) async{
    //print(gameJson);
    int coverId = gameJson['cover'];
    //print(coverId);
    //print(headers);
    JsonList response = await post(
        '$protocol://$baseUrl/covers',
      headers: headers,
      body: 'fields game,url; where id=$coverId;'
    ) as JsonList;
    //print(response);
    String thumbUrl = '${protocol}:${response[0]["url"]}';
    thumbUrl = thumbUrl.replaceFirst("t_thumb", "t_720p");
    return thumbUrl;
  }

  void test() async{
    login();
    JsonList gamesList = await searchGames("Halo");
    //print(gamesList);
    //getCoverUrl(gamesList[0]);
    String coverUrl = await getCoverUrl(gamesList[0]);
    print(coverUrl);

  }
}
