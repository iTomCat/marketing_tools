import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static const String databaseName = 'pancakes_recipes.db';

  static const String recipesTableName = 'recipes_table';

  static const String columnId = 'id'; // ID dokument recepies
  static const String columnTitle = 'title';
  static const String columnDescr = 'title';
  static const String columnImageUrl = 'image_url';
  //static const String columnUserEmail = 'user_email';

  //----------------------------------------------------------------------------  DB Instance
  static Future<sql.Database> database() async {
    //Twozrenie bazy lub podbranie istniejącej. join pozwala na łączenie ścieżki i nazwy bazy do jednego linku L300, 5:00
    final dbPath = await sql
        .getDatabasesPath(); //Tu podbranie sciezki do bazy jeżeli nie istnieje to zostanie stworzona ponizej

    debugPrint('DB Path: ${path.join(dbPath, databaseName)}');

    return sql.openDatabase(path.join(dbPath, databaseName),
        onCreate: (db, version) {
      return db.execute(
          // PO DODANYCH DANYCH DO BAZY TREZBA PRZEINSTRTALOWAĆ APLIKACJĘ
          'CREATE TABLE recipes_table('  // tu podać nazwę ..TableName
          //TODO zmienić  na integer primary key autoincrement, tak jak w przykładzie
          '$columnId TEXT PRIMARY KEY, '
          '$columnTitle TEXT, '
          '$columnDescr TEXT, '
          '$columnImageUrl TEXT)'); // Tworzymy pola w bazie, REAL to jest double
    }, version: 1);
  }



  //----------------------------------------------------------------------------  Insert to DB
  static Future<void> insertToDB (String table, Map<String, Object> data) async{

    final db = await DBHelper.database(); // pobireanie instancji lub tworzenie nowej bazy

    // Jeżeli mamy już bazę dodajemy dane. ConflictAlgorithm.replace znaczy jeżeli mamy już id dodane wcześneij to nadpisujemy dane w tym id
    db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //----------------------------------------------------------------------------  Get from DB - wszystko
  static Future<List<Map<String, dynamic>> >getData(String table) async {
    final db = await DBHelper.database(); // pobireanie instancji lub tworzenie nowej bazy
    return db.query(table);  //query method - pobieranie z bazy. Filtrowanie otrzymanych danych można znaleźć w opisie np na pub.dev - sqflite
  }


  //---------------------------------------------------------------------------- Delete from DB
  static Future<int> deleteFromDB(String id) async {
    final db = await DBHelper.database(); // pobireanie instancji lub tworzenie nowej bazy
    return await db.delete(recipesTableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
