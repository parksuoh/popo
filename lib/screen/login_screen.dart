import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popo/screen/main_screen.dart';
import 'package:popo/screen/register_screen.dart';
import 'package:dio/dio.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String path = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? userToken;

  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    loginInit();

  }

  Future loginInit() async{
    userToken = await storage.read(key : "token");

    if(userToken != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
              (route) => false
      );
    }



  }



  Future _loginDio(String? email, String? password) async{
    var dio = Dio();

    try {
      final response = await dio.post('http://${MainScreen.localhostPath}:3000/api/user/applogin',
          data: {'email': email, 'password': password});

      if(response.statusCode == 200) {
        if(response.data['loginSuccess'] == false){
          return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('이메일 비밀번호를 정확히 확인해 주세요!'),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                  label: '확인', //버튼이름
                  onPressed: (){}, //버튼 눌렀을때.
                ),
              )
          );;
        } else {
          await storage.write(
            key: "token",
            value: response.data['token'],
          );

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
                  (route) => false
          );

          _emailController.text = "";
          _passwordController.text = "";
        }


      }

    } catch (e) {
      print("Exception: $e");
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인', style: TextStyle(color: Colors.black),),
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
            SizedBox(height: 5,),
            TextButton(onPressed: () async{
              if(_emailController.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('이메일을 입력해 주세요!'),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(
                        label: '확인', //버튼이름
                        onPressed: (){}, //버튼 눌렀을때.
                      ),
                    )
                );
              } else if (_passwordController.text == ""){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('비밀번호를 입력해 주세요!'),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(
                        label: '확인', //버튼이름
                        onPressed: (){}, //버튼 눌렀을때.
                      ),
                    )
                );
              } else {
                await _loginDio(_emailController.text, _passwordController.text);
              }

            }, child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Center(child: Text("로그인", style: TextStyle(color: Colors.black54),))
              )
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
                child: Center(child: TextButton(onPressed:  () {
                  Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        // settings: RouteSettings(name: RegisterScreen.path),
                          builder: (BuildContext context) => RegisterScreen()
                      )
                  );}, child: Text("회원가입하러가기", style: TextStyle(color: Colors.black54)),))
            ),

          ],
        ),
      ),
    );
  }
}

