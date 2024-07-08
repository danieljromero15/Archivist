import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_keys.dart';

typedef Json = Map<String, dynamic>;
typedef JsonList = List<dynamic>;

class IGDBApi {
  static String authToken = '';

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
      //print('${uri}\n${response.statusCode}');
      throw const FormatException('Unable to reach IGDB');
    }
  }

  Future<void> login() async {
    Json response = await post(
        'https://id.twitch.tv/oauth2/token?client_id=$igdbApiKey&client_secret=$igdbApiSecret&grant_type=client_credentials') as Json;
    authToken = response['access_token'];
  }

  Future<JsonList> searchGames(String name) async {
    if (authToken.isEmpty) {
      await login();
    }
    JsonList response = await post('$protocol://$baseUrl/games',
        headers: {
          "Client-ID": igdbApiKey,
          "Authorization": 'Bearer $authToken',
        },
        body: 'search "$name"; fields name, cover, first_release_date;') as JsonList;
    return response;
  }
}
