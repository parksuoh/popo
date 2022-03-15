import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:popo/screen/chat_screen.dart';
import 'package:popo/screen/main_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final LoginProvider loginProvider;
  const ChatRoomScreen({Key? key, required this.loginProvider}) : super(key: key);
  static const String path = "/chatrooms";

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late List<dynamic> chatRoomData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getChatRoom();
    });

  }




  Future getChatRoom() async{
    var dio = Dio();

    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/chatroom/chatroomlist',
          queryParameters: {'id': this.widget.loginProvider.id});
      if(response.statusCode == 200) {
        setState(() {
          chatRoomData = response.data;
          print(chatRoomData[0]['users'].where((a) =>
            a["_id"] != this.widget.loginProvider.id
          ).toList()[0]['nickname']);
        });
      }

    }
    catch(e) {
      print(e);
    }

  }


  List<Widget> _itemList(){
    return chatRoomData.map((item) {
      String friendNick = item['users'].where((a) => a["_id"] != this.widget.loginProvider.id).toList()[0]['nickname'];
      return ChatRoom(chatRoomId:item['_id'], loginProvider: this.widget.loginProvider, friendNick: friendNick,);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('채팅방', style: TextStyle(color: Colors.black),),
          actions: [
            TextButton(
              onPressed: () async{
                getChatRoom();
              },
              child: Text('새로고침', style: TextStyle(color: Colors.black),),
            )
          ],
        ),
        body: ListView(
          children: _itemList()
        ),
    );
  }
}




class ChatRoom extends StatelessWidget {
  final String chatRoomId;
  final LoginProvider loginProvider;
  final String friendNick;
  ChatRoom({Key? key, required this.chatRoomId, required this.loginProvider, required this.friendNick}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await  Navigator.of(context).push<String>(
            MaterialPageRoute(
                settings: RouteSettings(name: ChatScreen.path),
                builder: (BuildContext context) => ChatScreen(chatRoomId:chatRoomId, loginProvider: loginProvider,)
            )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/default_user.jpeg'),
                  ),
                  borderRadius: BorderRadius.circular(30.0)
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(friendNick, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis),
                  Text("님과 대화", overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text("오후 5:28", style: TextStyle(color: Colors.grey,),),
          ],
        ),
      ),
    );;
  }
}
