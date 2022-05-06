# flutter, nodejs 포트폴리오 입니다.(1.0)

사용기술 flutter, nodejs, mongoDB

## 설명

flutter 를 사용하여 ios aos 동시 개발
nodejs 와 mongodb를 사용하여 백엔드 구현

로그인 화면
 - dio를 이용하여 백엔드와 http 통신하여 jwt를 활용한 로그인 구현
 - 로그인 후 FlutterSecureStorage에 jwt 저장하여 로그아웃 하지않으면 자동 로그인 기능
 - 로그인 후 loginProvider 에 유저 정보 저장

회원가입 화면
 - dio이용 mongoDB에 새로운 user 저장

홈 화면 
 - 아무기능 없음 UI만

친구 화면
- dio 이용 자신을 제외한 유저정보를 가져옴
- 친구와 채팅하기 누를시 채팅방이 존재하지 않는다면 채팅방 생성후 입장, 채팅방이 존재한다면 바로입장

채팅방 화면
- dio 이용 나를 포함하고 있는 체팅방 목록을 가져옴
- 채팅방 클릭시 채팅방 입장

채팅 하면
- dio 이용 현재 채팅방에 포함됨 채팅 목록을 모두 불러옴
- socket_io_client 와 soket.io 이용한 실시간 통신

유저 화면
- 로그아웃 클릭시 provider에 유저정보를 모두 삭제
- FlutterSecureStorage에 jwt 삭제


## 부족한점
- nullsafy에 적응 부족
- flutter lifecycle에 대한 이해와 사용능력부족
- provider 효율적 사용 부족
- class 에 private public 에 사용능력 부족

등등 아직 부족한 부분이 많으나 잘부탁합니다.
