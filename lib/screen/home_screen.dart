import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List cardList1 = [1, 2, 3, 4, 5, 6];

  final List cardList2 = [
    {"text1": "뉴트리원 브랜드데이", "text2": "최대 90%할인+12% 적립"},
    {"text1": "키엘 투명 에센스", "text2": "전 품목 할인+쿠폰+증정이벤트"},
    {"text1": "투쿨포스쿨 마스카라", "text2": "대세는 뿌리! 속눈썹 마술"},
    {"text1": "미미언니의 신상 EAT쇼", "text2": "풀무원 쉬림프가츠 출시"},
  ];

  List<Widget> HomeCardList1(){
    return cardList1.map((item)=> HomeCard1()).toList();
  }

  List<Widget> HomeCardList2(){
    return cardList2.map((item)=> HomeCard2(text1: item["text1"], text2: item["text2"],)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
        actions: [
          IconButton(icon: Icon(Icons.all_inbox_rounded), onPressed: null),
          IconButton(icon: Icon(Icons.add_alert_outlined), onPressed: null),
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                ),
              ),
              Positioned(
                width: 40,
                height: 40,
                top: 5,
                left: 10,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/default_user.jpeg'),
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.wb_sunny, size: 40,),
                  SizedBox(width: 10,),
                  Text('17°맑음', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), ),
                  SizedBox(width: 10,),
                  Text('어제보다 2° 높아요'),
                ],
              ),
            ),

            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("NOW.",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                          )
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/default_user.jpeg'),
                                ),
                              ),
                              Text("3/15 9시 몬스타엑스 기현 스페셜  >", style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: HomeCardList1()
                        ),
                      ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))
                          ),
                          child: Center(child: Text("나우 편성표", style: TextStyle(fontSize: 20, color: Colors.white60),)),
                        ),
                        Container(
                          height: 40,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey
                          ),
                          child: Center(child: Text("|", style: TextStyle(fontSize: 20, color: Colors.white60),)),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Center(child: Text("쇼핑 편성표", style: TextStyle(fontSize: 20, color: Colors.white60),)),
                        ),
                      ],

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_ic_call,
                    size: 27,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(width: 5,),
                  Text("내 주변"),
                  Text(" 코로나19 전화상담 병의원", style: TextStyle(color: Colors.lightBlue),),
                  Text("을 확인하세요!"),
                ],
              )
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.addchart, size: 23,),
                        Text("확진현황", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.alt_route_sharp, size: 23,),
                        Text("잔여백신알림", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_location, size: 23,),
                        Text("선별진료소", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.wb_auto_outlined, size: 23,),
                        Text("팩트체크", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                  ],
                )
            ),
            SizedBox(height: 10,),
            Column(
              children: HomeCardList2(),
            ),
            SizedBox(height: 10,),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("오늘의...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        Text("더보기>", style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
                  Expanded(
                      child: Swiper(
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            child: Stack(
                              children: [
                                Positioned(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 230,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/KakaoTalk_Photo_2022-03-13-20-56-25.jpeg'),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          );
                        },
                        itemCount: 5,
                        viewportFraction: 0.8,
                        scale: 0.9,
                        pagination: SwiperPagination(
                            margin: EdgeInsets.only(top: 10)
                        ),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      )
    );
  }
}


class HomeCard1 extends StatelessWidget {
  const HomeCard1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(
                    'assets/images/KakaoTalk_Photo_2022-03-13-14-13-11.jpeg'),
              ),
            ),
          ),
          Text("경주 갔던 사진"),
        ],
      ),
    );
  }
}

class HomeCard2 extends StatelessWidget {
  final String text1;
  final String text2;
  HomeCard2({Key? key, required this.text1, required this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text1, style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),),
                    Text(text2)
                  ],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/default_user.jpeg'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              child: Center(
                child: Text(
                  '사이드 메뉴',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('홈'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('친구'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.chat_bubble_fill),
            title: Text('채팅'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.ellipsis),
            title: Text('유저'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}