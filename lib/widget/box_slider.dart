// box_slider.dart
import 'package:flutter/material.dart';
import 'package:telemedicine_app1/model/model_member.dart';

class BoxSlider extends StatelessWidget {
  final List<Member> members;
  BoxSlider({required this.members});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('의사 리스트'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, members),
            ),
          )
        ],
      ),
    );
  }

}
List<Widget> makeBoxImages(BuildContext context, List<Member> members) {
  List<Widget> results = [];
  for (var i = 0; i < members.length; i++) {
    results.add(InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('image/' + members[i].photo),
        ),
      ),
    ));
  }
  return results;
}

