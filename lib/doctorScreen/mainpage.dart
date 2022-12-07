import 'package:flutter/material.dart';
import 'package:telemedicine_app1/doctorScreen/reservation.dart';

import 'agree.dart';
import 'consult.dart';
import 'mypage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "진료예약"),
                Tab(text: "진료시작"),
                Tab(text: "진료내역"),
                Tab(text: "마이페이지"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AgreePage(),
              ConsultPage(),
              ReservationPage(),
              MyPage(),
            ],
          ),
        ));
  }
}
