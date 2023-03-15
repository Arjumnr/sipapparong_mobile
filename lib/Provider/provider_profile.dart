import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Data/Database/db_provider.dart';
import '../Data/service.dart';

class ProfileProvider extends ChangeNotifier {
  final DatabaseProvider _databaseProvider = DatabaseProvider();
  // DataUser dataUser = DataUser();
  var result, token, url;

  getDataProfile() async {
    token = await _databaseProvider.getToken();
    if (token != null) {
      log('Ada T ');
      // log(token);
      url = Uri.parse(GET_PROFILE);
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

  updateProfile(String email, noHp, address, BuildContext context) async {
    token = await _databaseProvider.getToken();
    if (token != null) {
      log('Ada T ');
      // log(token);
      url = Uri.parse(UPDATE_PROFILE);
      var header = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token ",
      };
      var body = {
        "email": email,
        "phone_number": noHp,
        "address": address,
      };
      var response =
          await http.put(url, headers: header, body: jsonEncode(body));

      if (response.statusCode == 200) {
        result = jsonDecode(response.body)['success'];
        return result;
      } else {
         result = jsonDecode(response.body)['success'];
        return result;
      }
    }
  }

  logout() async {
    await _databaseProvider.deleteToken();
    notifyListeners();
  }
}
