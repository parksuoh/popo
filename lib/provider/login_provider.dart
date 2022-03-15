import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popo/screen/main_screen.dart';

class LoginProvider with ChangeNotifier{
  late String id;
  late String email;
  late String nickname = "";
  late int role;
  late String image;
  String? userToken;

  static final storage = new FlutterSecureStorage();

  LoginProvider() {}

  Future init() async{

    userToken = await storage.read(key : "token");

    var dio = Dio();
    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/user/appauth',
      options: Options(
        headers: {'token': userToken}
      ));

      if(response.statusCode == 200) {
        id = response.data['_id'];
        email = response.data['email'];
        nickname = response.data['nickname'];
        role = response.data['role'];
        image =  response.data['image'];

      }

      this.notifyListeners();
    }
    catch(e) {
      print(e);
    }
  }

  String getUserId() {
    return this.id;
  }

  Future clear() async {
    id = "";
    email = "";
    nickname = "";
    role = 0;
    image = "";
    userToken = null;

    await storage.delete(key : "token");

    this.notifyListeners();
  }


}