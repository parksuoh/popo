import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:popo/screen/chatrooms_screen.dart';
import 'package:popo/screen/friends_screen.dart';
import 'package:popo/screen/home_screen.dart';
import 'package:popo/screen/user_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String path = "/";
  // static const String localhostPath = "192.168.0.7";
  // static const String localhostPath = "192.168.249.239";
  static const String localhostPath = "59.22.21.84";

  @override
  Widget build(BuildContext context) {
    final LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    return MainScreenDetail(loginProvider: _loginProvider,);
  }
}



class MainScreenDetail extends StatefulWidget {
  final LoginProvider loginProvider;
  const MainScreenDetail({Key? key, required this.loginProvider}) : super(key: key);


  @override
  State<MainScreenDetail> createState() => _MainScreenDetailState();
}

class _MainScreenDetailState extends State<MainScreenDetail> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initProvider();
  }

  Future initProvider() async{
    this.widget.loginProvider.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          FriendsScreen(loginProvider: this.widget.loginProvider),
          ChatRoomScreen(loginProvider: this.widget.loginProvider),
          UserScreen(loginProvider: this.widget.loginProvider,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈",),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "친구"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_fill), label: "체팅",),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.ellipsis), label: "유저",),
        ],
      ),
    );
  }
}
