import 'package:routine/models/routine_model.dart';
import 'package:routine/models/routine_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper _databaseHelper;

  String routineTable = 'routine_table';
  String colId = 'id';
  String colDescription = 'description';
  String colDuration = 'duration';

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "routine.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $routineTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDescription TEXT, $colDuration TEXT)',
        );
      },
    );
    return database;
  }

  Future<int> insertRoutine(RoutineModel routine) async {
    if (routine == null) {
      print('null dayo');
    }
    Database db = await this.database;
    print(routine.description);

    final int result = await db.insert(
      routineTable,
      routine.toMap(),
    );
    print('result: $result');
    return result;
  }

  Future<List<RoutineModel>> getRoutine() async {
    List<RoutineModel> _routines = [];

    var db = await this.database;
    var result = await db.query(routineTable);
    result.forEach(
      (element) {
        var routinInfo = RoutineModel.fromMap(element);
        _routines.add(routinInfo);
      },
    );

    return _routines;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(routineTable, where: '$colId = ?', whereArgs: [id]);
  }
}
