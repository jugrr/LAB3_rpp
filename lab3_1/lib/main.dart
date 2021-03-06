import 'package:flutter/material.dart';
import 'ThirdPage.dart';
import 'database.dart';
import 'loader.dart';
import 'SecondPage.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(body: LoadingScreen()),
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({Key key, this.db}) : super(key: key);
  final Database db;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 155, 210), // Color.fromARGB(255, 54, 155, 169),
      body: Center(child:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                color: Colors.white,
                width: 1
                )
              ),
            splashColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 69),
            onPressed: ()async{
              List list = await DBProvider().display(widget.db);
              print(list);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListPage(list: list)));
            },
            child: Text('Вывести данные', style: TextStyle(fontSize: 20, color: Colors.white),),
          ),
          const SizedBox(height:30),
          MaterialButton(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                color: Colors.white,
                width: 1
                )
              ),

            splashColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 68),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddList(db: widget.db)));
            },
            child: Text('Добавить запись', style: TextStyle(fontSize: 20, color: Colors.white),),
            
          ),
          const SizedBox(height:30),
          MaterialButton(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                color: Colors.white,
                width: 1
                )
              ),
            splashColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 19),
            onPressed: ()async{
              List list = await DBProvider().display(widget.db);
              List <RandomStudent> slist = List.generate(list.length, (i){
              return RandomStudent(
                fio: list[i]["FIO"],
                id: list[i]["ID"],
                date: list[i]["DATE"],
              );
            });
            print(slist);
            DateTime max = DateTime.parse(slist[0].date);
            RandomStudent tmp = slist[0];
            for (int i = 0; i < slist.length;i++){
              if(DateTime.parse(slist[i].date).isAfter(max)){
                max = DateTime.parse(slist[i].date);
                tmp = slist[i];
              }
            }
            RandomStudent rs = RandomStudent(date: tmp.date, id: tmp.id, fio: 'Иванов Иван Иванович');
            await DBProvider().update(widget.db, rs);
            },
            child: Text('Замена в последней записи', style: TextStyle(fontSize: 20, color: Colors.white),),
          ),
        ],
      ),
      )
    );
  }
}