import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popo/screen/login_screen.dart';
import 'package:popo/screen/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String path = "/register";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  Future<bool> _registerDio(email, password, nickname) async{
    var dio = Dio();

    try {
      final response = await dio.post('http://${MainScreen.localhostPath}:3000/api/user/register',
          data: {'email': email, 'password': password, 'nickname': nickname});
      if(response.statusCode == 200) {
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
        title: Text('회원가입', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Container(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image(
                  image: AssetImage(
                      'assets/images/default_user.jpeg'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: this._emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: "Email",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: this._passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: "Password",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: this._nicknameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: "Nickname",
                ),
              ),
            ),
            SizedBox(height: 10,),
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
                  bool registerRes = await _registerDio(_emailController.text, _passwordController.text, _nicknameController.text);
                  if(registerRes == true) {
                    Navigator.of(context).push<String>(
                        MaterialPageRoute(
                            settings: RouteSettings(name: LoginScreen.path),
                            builder: (BuildContext context) => LoginScreen()
                        )
                    );
                  }
                }, child: Text("회원가입", style: TextStyle(color: Colors.black54)),)
              ),
            )
          ],
        ),
      ),
    );
  }
}
