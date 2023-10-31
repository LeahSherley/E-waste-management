import 'package:quiz_app/models/myschedules.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MySchedulesDatabase {
  static final MySchedulesDatabase instance = MySchedulesDatabase._init();

  static Database? _database;
  MySchedulesDatabase._init();

  Future get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('mySchedules.db');
    return _database!;
  }


  


  Future <Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("Path: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future  _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE mySchedules(
        id $idType,
        title $textType,
        date $textType,
        time $textType,
        address $textType,
        number $textType,
        isPicked $boolType
      )
    ''');
  }

  Future insertSchedule(mySchedules schedule) async {
    final db = await database;
    await db.insert(
      'mySchedules', 
      schedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
      
  }

  Future deleteSchedule(String scheduleID) async {
    final db = await database;
     try {
    print("Deleting schedule with ID: $scheduleID");
    await db.delete(
      'mySchedules',
      where: 'id = ?',
      whereArgs: [scheduleID],
    );
  } catch (e) {
    print("Error deleting schedule: $e");
  }
  }
  

  Future <List<mySchedules>> getAllSchedules() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mySchedules');
    return List.generate(maps.length, (i) {
      return mySchedules.fromMap(maps[i]);
    });
  }
}
