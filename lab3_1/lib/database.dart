import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:math';

class DBProvider{
  Database database1;
  static const String dbpath = 'MyDB.db';
  String _path;



  //empty constructor
DBProvider();

  //openDB
  Future<Database> openDB()async{
      _path = join(await getDatabasesPath(), dbpath);
      database1 = await openDatabase(_path,
    onCreate: (Database db, version)async{
      await db.execute('CREATE TABLE Students (ID INTEGER, FIO TEXT, DATE TEXT)');
      print('a');
    },
    onOpen: (Database db)async{
      print('b');
      await db.execute('DELETE FROM Students');   
      for(int i = 0; i < 5; i++){
        Random rnd = Random();
        RandomStudent rs = RandomStudent(id: rnd.nextInt(99999)+10000, fio: RandomStudent().getFIO(), date: DateTime.now().toIso8601String(),);
        print(rs);
        db.insert('Students', rs.toMap());
        
      }
    },

    version: 1,
    );
    return database1;
  }
  
  //display
  Future display(Database db)async{
    List<Map<String, dynamic>> a = await db.query('Students');
    return a;
  }
  Future close(Database db)async{
    await db.close();
  }
  //insert
  Future insert(Database db, RandomStudent rs)async{
    return await db.insert('Students', rs.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  Future update(Database db, RandomStudent rs)async{
    return await db.update('Students', rs.toMap(), where: 'ID = ?', whereArgs: [rs.id]);
  }
  Future show(Database db)async{
    List<Map<String, dynamic>> a = await db.query('Students');
    print(a);
  }
}


class RandomStudent{
  final int id;
  final String date;
  final String fio;
  final listfio = [
    "Антоновича Анна Давидовна",
    "Агейкина Варвара Потаповна",
    "Табернакулова Злата Емельяновна",
    "Балабанова Маргарита Карповна",
    "Кондратьев Никон Егорович",
    "Якина Екатерина Потаповна",
    "Базаров Антип Сигизмундович",
    "Яцунов Борислав Артемович",
    "Сюкосева Розалия Александровна",
    "Гребнев Кирилл Валериевич",
    "Чечуров Кирилл Артемиевич",
    "Божко Бронислава Елисеевна",
    "Ельцов Эммануил Егорович",
    "Чаадаева Вероника Алексеевна",
    "Церетели Всеслава Несторовна",
    "Труш Всеволод Назарович",
    "Маркелова Элеонора Юлиевна",
    "Блинова Милена Борисовна",
    "Шеншина Ольга Тихоновна",
    "Свечников Артемий Даниилович",
    "Ямзин Савелий Проклович",
    "Гика Майя Данииловна",
    "Матеров Карл Левович",
    "Коротченко Платон Дмитриевич",
    "Кубланова Инесса Евгениевна",
    "Кабанова Таисия Захаровна",
    "Коллеров Федот Ираклиевич",
    "Бессмертный Роман Онуфриевич",
    "Наполов Дементий Кондратович",
    "Хохорин Вадим Сидорович",
    "Фирсов Кирилл Онисимович",
    "Швецова Изольда Станиславовна",
    "Соломонов Алексей Матвеевич",
    "Травкин Ираклий Давидович",
    "Яхненко Доминика Данииловна",
    "Греф Эдуард Кириллович",
    "Рыжова Татьяна Павеловна",
    "Маркелова Полина Захаровна",
    "Розанов Эрнест Назарович",
    "Артемьев Виктор Прохорович",
    "Валюхова Марина Вячеславовна",
    "Носачёв Денис Ипатович",
    "Луковников Трофим Иосифович",
    "Харьков Федор Ефремович",
    "Ермакова Ярослава Родионовна",
    "Стаин Евгений Левович",
    "Лунина Регина Филипповна"
  ];

  RandomStudent({this.date, this.id, this.fio});

  Map<String, dynamic> toMap(){
    return{
      'ID': id,
      'FIO': fio,
      'DATE': date,
    };
  }

@override
String toString() {
return 'Student{id: $id, fio: $fio, date: $date,}';
 }

  String getFIO (){
    Random random = Random();
    return listfio[random.nextInt(listfio.length-1)];
  }

  toArr(String a){
    return a.split(" ");
  }
  
}

