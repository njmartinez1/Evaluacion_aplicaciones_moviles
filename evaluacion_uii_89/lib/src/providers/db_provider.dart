import 'dart:io';
import 'package:evaluacion_uii_89/src/models/insumo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider dbProvider = DBProvider._();

  DBProvider._();

  Future<Database?>? get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'Trifasic89.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Insumos (
          id  INTEGER PRIMARY KEY,
          tipo  INTEGER,
          nombre TEXT,          
          descripcion TEXT          
        )      
      ''');
    });
  }

  Future<int> insert(Insumo newElement) async {
    //INSERT INTO Insumo VALUES
    final Database? db = await database;
    final newId = await db!.insert('Insumos', newElement.toJson());
    return newId;
  }

  Future<List<Insumo>> list() async {
    //SELECT * FROM Insumo
    final Database? db = await database;
    final result = await db!.query('Insumos');
    return result.isNotEmpty
        ? result.map((t) => Insumo.fromJson(t)).toList()
        : [];
  }
}