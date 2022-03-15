import 'package:flutter/material.dart';
import 'package:popo/screen/login_screen.dart';
import 'package:popo/screen/main_screen.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final bool logined = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (RouteSettings routeSettings) {
          print("rs: ${routeSettings.name} / ${routeSettings.arguments?.toString()}");
          if (logined == true){
              return MaterialPageRoute(
                  settings: RouteSettings(name: MainScreen.path),
                  builder: (BuildContext context) => MainScreen());
            }

          return MaterialPageRoute(
              settings: RouteSettings(name: LoginScreen.path),
              builder: (BuildContext context) => LoginScreen());
          }

      ),
    );
  }
}

