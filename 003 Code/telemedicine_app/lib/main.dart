
import 'package:flutter/material.dart';
import 'package:telemedicine_app1/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA9zQlkh5Q1OgsZDFot-koarbj3PifyZsY", // Your apiKey
      appId: "1:870698944767:android:653d86ea0ae2240d1524ca", // Your appId
      messagingSenderId: "870698944767", // Your messagingSenderId
      projectId: "telemedicine-app-2c261", // Your projectId
    ),

  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'telemedicine app',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: LoginSignupScreen(),
    );
  }
}
