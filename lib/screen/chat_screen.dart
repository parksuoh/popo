import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popo/provider/login_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'main_screen.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final LoginProvider loginProvider;
  const ChatScreen({Key? key, required this.chatRoomId, required this.loginProvider}) : super(key: key);
  static const String path = "/chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final IO.Socket socket;
  late List<dynamic> messages = [];

  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();

  late final double chatListHeight;


  @override
  void initState() {
    super.initState();
    init();

    socket.emit('join-room', this.widget.chatRoomId);

    socket.on('receive-message', (msgData) {
      Map<String, dynamic> receiveMsg = jsonDecode(msgData);
      setState(() {
        messages.add(receiveMsg);
      });

    });
  }

  @override
  void dispose() {
    _textController.dispose();
    socket.emit('leave-room', this.widget.chatRoomId);
    super.dispose();
  }
  
  Future init() async{
    getChats();
    await connectSocket();

  }

  Future getChats() async{
    var dio = Dio();

    try {
      final response = await dio.get('http://${MainScreen.localhostPath}:3000/api/chat/getchats',
          queryParameters: {'chatRoomId': this.widget.chatRoomId});
      if(response.statusCode == 200) {
        setState(() {
          messages = response.data;
        });

      }else{
        print('실패');
      }

    }
    catch(e) {
      print(e);
    }

  }

  void scrollAnimate(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }
  
  Future connectSocket() async{
    socket = IO.io('http://${MainScreen.localhostPath}:3000', IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((data) =>  print('연결 완료'));

  }

  List<Widget> _chatList(){
    return messages.map((item)=> item['userId'] == this.widget.loginProvider.id ?
        MyChat(text: item['text'], time: '11:12',)
        : Chat(nickname: item['nickname'], text: item['text'], time: '11:11',)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅', style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: () async{
              getChats();
            },
            child: Text('새로고침', style: TextStyle(color: Colors.black),),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            controller: _scrollController,
            children: _chatList(),
          )),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  icon: Icon(Icons.add),
                  iconSize: 25,
                  onPressed: () {},
                ),
                Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: 1,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    )
                ),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  icon: Icon(Icons.send),
                  iconSize: 25,
                  onPressed: () {
                    Map<String, dynamic> msgData = {
                      'userId' : this.widget.loginProvider.id,
                      'email' : this.widget.loginProvider.email,
                      'nickname' : this.widget.loginProvider.nickname,
                      'image' : '',
                      'text' : _textController.text,
                      'chatRoomId': this.widget.chatRoomId
                    };
                    final String jsonMsgData = jsonEncode(msgData);

                    setState(() {
                      messages.add(msgData);
                    });

                    socket.emit('message', jsonMsgData);
                    _textController.text = '';
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class Chat extends StatelessWidget {
  final String nickname;
  final String text;
  final String time;
  const Chat({Key? key, required this.nickname, required this.text, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/default_user.jpeg'),
          ),
          SizedBox(width: 10),
          Container(

            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nickname),
              Container(
                constraints: BoxConstraints(minHeight: 20, maxWidth: MediaQuery.of(context).size.width * 0.5),
                child: Text(text),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.grey,
                ),
              )
            ],
          ),
          ),
          SizedBox(width: 5),
          Text(time, style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}


class MyChat extends StatelessWidget {
  final String text;
  final String time;
  const MyChat({Key? key, required this.text, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(fontSize: 12),),
          SizedBox(width: 5),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 20, maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Text(text),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}