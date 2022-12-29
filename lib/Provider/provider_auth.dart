// ignore_for_file: prefer_typing_uninitialized_variables, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/Database/db_provider.dart';
import '../Data/service.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider extends ChangeNotifier {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  Status _loggedInStatus = Status.Uninitialized;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
    notifyListeners();
  }

  Future<bool> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    return token.isNotEmpty;
  }

  Future<Map<String, dynamic>> login(
      String nopPbb, String pass, BuildContext context) async {
    
    var result, token,expToken;
    final url = Uri.parse(LOGIN);
    
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    http.Response res = await http.post(
      url,
      body: {
        'nop_pbb': nopPbb,
        'password': pass,
      },
    );

    if (res.statusCode == 200) {
      result = jsonDecode(res.body);
      _loggedInStatus = Status.Authenticated;
      //save token
      token = result['data']['token'];
      expToken = result['data']['session_lifetime'];
      _databaseProvider.saveToken(token, expToken);
      notifyListeners();
      return result;
    } else {
      result = jsonDecode(res.body);
      _loggedInStatus = Status.Unauthenticated;
      notifyListeners();
      return result;
    }
  }
}
