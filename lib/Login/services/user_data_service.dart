import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/Login/model/model.dart';
import 'package:flutter_mvvm/Login/services/remote/network/ApiEndPoints.dart';
import 'package:flutter_mvvm/Login/services/remote/network/BaseApiService.dart';
import 'package:flutter_mvvm/Login/services/remote/network/NetworkApiService.dart';
import 'package:http/http.dart' as http;

class UserDataService extends ChangeNotifier{
  String userUrl = 'https://reqres.in/api/users';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Data>? users = [];
   /*
  Future<List<Data>?> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    final result = await http.get(Uri.parse(userUrl)).catchError((e) {
      print('Error Fetching Users');
    });

    if(result.statusCode == 200){
      Map<String, dynamic> data = json.decode(result.body);
      var _users = data["data"];
      if (_users != null) {
        users = User.fromJson(data).data;
      }
      _isLoading = false;
      notifyListeners();
      return users;
    }
    else{
      _isLoading = false;
      notifyListeners();
      throw Exception('Error - ${result.statusCode}');
    }
  }
    */
  final BaseApiService _apiService = NetworkApiService();
  
  @override
  Future<User> getUserData() async {
    try {
     // dynamic response = await _apiService.getResponse(ApiEndPoints().USER_DATA);
      dynamic response = await _apiService.getResponse(ApiEndPoints().USER_DATA);
      print("Log: $response");
      final jsonData = User.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

}
