//import 'package:rugby_mobile/pages/api/TeamData.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rugby_mobile/pages/api/TeamData.dart';

class RemoteService {

  Future<Post> getTeamsData() async {
    headers() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
    final response = await  http.get(Uri.parse('https://sports-info-api.onrender.com/v1/public/fixtures'), headers: headers());

    return Post.fromJson(response.body);
  }
}
