import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:popo/screen/login_screen.dart';
import 'package:popo/screen/main_screen.dart';


class UserScreen extends StatelessWidget {
  final LoginProvider loginProvider;

  UserScreen({Key? key, required this.loginProvider}) : super(key: key);
  static const String path = "/user";


  static final storage = FlutterSecureStorage();


  Future<bool> _logoutDio() async{
    String? _userToken = await storage.read(key : "token");

    var dio = Dio();

    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/user/logout',
          options: Options(
              headers: {'token': _userToken}
          ));

      if(response.statusCode == 200) {
        this.loginProvider.clear();
        return true;
      }

    } catch (e) {
      print("Exception: $e");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('유저', style: TextStyle(color: Colors.black),),
        ),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/default_user.jpeg'),
                ),
                SizedBox(width: 40,),
                Text(this.loginProvider.nickname != null ? this.loginProvider.nickname : '닉넴'),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),

              ),
              child: Center(child: TextButton(onPressed: () async{
                bool logoutResult = await _logoutDio();

                if(logoutResult == true) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                          (route) => false
                  );
                }

              }, child: Text("로그아웃", style: TextStyle(color: Colors.black54))) )
          ),

        ]
      ),
    );
  }
}
