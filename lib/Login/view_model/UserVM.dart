import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Login/model/model.dart';
import 'package:flutter_mvvm/Login/services/remote/response/ApiResponse.dart';
import 'package:flutter_mvvm/Login/services/user_data_service.dart';


class UserVM extends ChangeNotifier {
  final _myRepo = UserDataService();

  ApiResponse<User> userModel = ApiResponse.loading();

  void _setUserMain(ApiResponse<User> response) {
    print("Response: $response");
    userModel = response;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    _setUserMain(ApiResponse.loading());
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setUserMain(ApiResponse.error(error.toString())));
  }
}
