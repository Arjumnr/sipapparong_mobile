import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider {
  //
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String _token = '';
  String _expToken = '';
  String get token => _token;
  String get expToken => _expToken;
  DateTime dateNow = DateTime.now();
  //split date
  // var dates = DateTime.now().toString().split('.')[0];

  //convert to date

  Future<List> saveToken(String token, expToken) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
    value.setString('expToken', expToken);
    print('on Save T');
    var data = [];
    data.add(token);
    data.add(expToken);
    return data;
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;
    _token = value.getString('token') ?? '';
    return _token;
  }

  Future<String> getExpToken() async {
    SharedPreferences value = await _pref;
    _expToken = value.getString('expToken') ?? '';
    return _expToken;
  }

  deleteToken() async {
    SharedPreferences value = await _pref;
    value.remove('token');
    value.remove('expToken');
    return 'T deleted';
  }

  Future<bool> checkToken() async {
    SharedPreferences value = await _pref;
    var getToken = value.getString('token');
    var getExpToken = value.getString('expToken');

    if (getToken != null) {
      var splitDateExp = getExpToken?.split('.')[0];
      var dateExpToString = splitDateExp.toString();
      var dateExp = DateTime.parse(dateExpToString);
      print('dateExp: $dateExp');
      print('dateNow: $dateNow');
      if (dateNow.isBefore(dateExp)) {
        return true;
      } else {
        return false;
      }
    } else {
      print('kosong');
      return false;
    }
  }
}
