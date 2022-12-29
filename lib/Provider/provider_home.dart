import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Data/Database/db_provider.dart';
import '../Data/service.dart';

class HomeProvider extends ChangeNotifier {
  DatabaseProvider databaseProvider = DatabaseProvider();
  var result, token, url;

  getDataHome() async {
    token = await databaseProvider.getToken();
    // print(token);
    if (token != null) {
      print('Ada T ');

      url = Uri.parse(GET_HOME);
     http.Response res = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token ",
        },
      );

      if (res.statusCode == 200) {
        result = jsonDecode(res.body)['data'];
        // print(result);
        return result;
      } else {
        result = jsonDecode(res.body)['message'];
        return result;
      }
    } else {
      print('Tidak Ada T ');
    }
  }
}
