import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telemedicine_app1/screens/mypage_screen.dart';
import 'package:telemedicine_app1/screens/doctorlist_screen.dart';
import 'package:telemedicine_app1/screens/treatmentstart_screen.dart';
import 'package:telemedicine_app1/widget/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authentication = FirebaseAuth.instance;
  final TextEditingController _filter =  TextEditingController();
  FocusNode focusNode =FocusNode();
  String _searchText = "검색 ";

  _HomeScreenState(){
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Telemedicine App',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SearchScreen(),
              TreatmentStart(),
              Container(),
              MyPageScreen(),

              
            ],
          ),
            bottomNavigationBar: Bottom(),
        )
      ),
    );
  }
}