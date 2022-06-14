import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: Container(
        height:50,
        child: TabBar(
          labelColor: Colors.lightBlueAccent,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                  text:"진료예약"
              ),
              Tab(
                  text:"진료시작"
              ),
              Tab(
                  text:"진료내역"
              ),
              Tab(
                  text:"마이페이지"
              ),
            ],
        ),
      ),
    );
  }
}