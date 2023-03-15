import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:sipapparong_mobile/Data/service.dart';

import '../Data/Database/db_provider.dart';
import 'package:http/http.dart' as http;


class TagihanProvider extends ChangeNotifier {
  DatabaseProvider databaseProvider = DatabaseProvider();
  var result, token, url;

  getListTagihan() async {
    token = await databaseProvider.getToken();
    // log(token);
    if (token != null) {
      log('Ada T ');

      url = Uri.parse(GET_HISTORY);
      http.Response res = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token ",
        },
      );
      // log(jsonDecode(res.body));
      if (res.statusCode == 200) {
        result = jsonDecode(res.body)['data'];

        return result;
      } else {
        result = jsonDecode(res.body)['message'];
        return result;
      }
    }
  }
}
