import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:popo/screen/main_screen.dart';

import 'chat_screen.dart';

class FriendsScreen extends StatefulWidget {
  final LoginProvider loginProvider;
  const FriendsScreen({Key? key, required this.loginProvider}) : super(key: key);
  static const String path = "/friends";

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late List<dynamic> friendsData = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getFriends();
    });
  }

  Future getFriends() async{
    var dio = Dio();

    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/user/friends',
          queryParameters: {'id': this.widget.loginProvider.id});
      if(response.statusCode == 200) {
        setState(() {
          friendsData = response.data;
        });
      }else{
        print('실패');
      }

    }
    catch(e) {
      print(e);
    }

  }

  List<Widget> _itemList(){
    return friendsData.map((item)=> friend_item(
        loginProvider: this.widget.loginProvider,
        myId: this.widget.loginProvider.id,
        friendId: item['_id'],
        nickname:item['nickname'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('친구', style: TextStyle(color: Colors.black),),
          actions: [
            TextButton(
              onPressed: () async{
                getFriends();
              },
              child: Text('새로고침', style: TextStyle(color: Colors.black),),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: _itemList()
              )
            )
          ],
        ),
    );
  }
}

class friend_item extends StatelessWidget {
  final LoginProvider loginProvider;
  final String myId;
  final String friendId;
  final String nickname;
  final String? image;
  const friend_item({
    Key? key, required this.nickname, this.image, required this.friendId, required this.myId, required this.loginProvider,
  }) : super(key: key);


  Future getFriends() async{
    var dio = Dio();
    String? chatRoomId;

    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/chatroom/gochatroom',
          queryParameters: {'friendId': friendId, 'myId': myId});

      if(response.statusCode == 200) {
        chatRoomId = response.data['ChatRoomId'];
        return chatRoomId;
      }
    }
    catch(e) {
      print(e);
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 100),
                        child: TextButton(onPressed: () async{
                          String chatRoomId = await getFriends();

                          await  Navigator.of(context).push<String>(
                              MaterialPageRoute(
                                  settings: RouteSettings(name: ChatScreen.path),
                                  builder: (BuildContext context) => ChatScreen(chatRoomId:chatRoomId, loginProvider: loginProvider,)
                              )
                          );

                        }, child: Text("채팅하기", style: TextStyle(color: Colors.black54)))
                      ));
                });


          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/default_user.jpeg'),
            ),
            title: Text(
              nickname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
      ),
    );
  }
}

