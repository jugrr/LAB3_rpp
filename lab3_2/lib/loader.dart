import 'package:flutter/material.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'main.dart';
import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Database db;
  RandomStudent rs;
  Random random = Random();

  @override
  void initState(){
    super.initState();
    startUP().then(
      (onValue){
      if(onValue){
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds:2200),
          transitionsBuilder: (context, animation, secondanimation, child){
            return FadeTransition(         
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: Semantics(
            scopesRoute: true,
            explicitChildNodes: true,
            child: child,
        ),
    );

          },
          pageBuilder: (context, a,b) => HomePage(db: db,)));
      }
      else{
        return;
      }
    }
    );
  }



Future<bool> startUP () async{
  try {
    await Future.delayed(Duration(microseconds: 1200));
    DBProvider provider = DBProvider();
    db = await provider.openDB();
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

  Future startDOWN()async{
  
  } 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 32, 196, 161),
                      Color.fromARGB(255, 32, 155, 210),
                      //Color.fromARGB(255, 32, 187, 210),
                  //Color.fromARGB(255, 61,255,188),
                  //Color.fromARGB(255, 61,251,255),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Padding(padding: EdgeInsets.only(top:50, bottom: 50),child:Text('Preparing...', style: TextStyle(color: Colors.white, fontSize: 25),))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
