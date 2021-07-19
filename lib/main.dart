import 'package:parisrooftops/model/userModel.dart';
import 'package:parisrooftops/screen/connection.dart';
import 'package:parisrooftops/screen/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'ParisRooftops',
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key ?key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _connected = false; var user;
// this function is call to verified if user has been connected before
// see its constructor in sharepref folder
  isConnected() async {
    // ignore: await_only_futures
    await UserModel.getUser();
    if (UserModel.sessionUser == null) {
      setState(() {
        _connected = false;
      });
    } else {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    isConnected();
    // this is set to load splash screen. If a user has been connected before we load the
    // the inscriptionSuccessview else we load the connectionView to allow user to create
    // an account
    var d = Duration(milliseconds:0);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return _connected ? Home() : Connection();
      }), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.black),
        ),
        
      ]),
    );
  }
}
