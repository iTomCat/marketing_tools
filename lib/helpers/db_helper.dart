import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static const String databaseName = 'pancakes_recipes.db';

  static const String userTableName = 'recipes_table';

  static const String columnId = 'id'; // ID dokument recepies
  static const String columnTitle = 'title';
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
          'CREATE TABLE users_table('
          //TODO zmienić  na integer primary key autoincrement, tak jak w przykładzie
          '$columnId TEXT PRIMARY KEY, '
          '$columnTitle TEXT, '
          //'$columnUserImage TEXT, '
          '$columnImageUrl TEXT)'); // Tworzymy pola w bazie, REAL to jest double
    }, version: 1);
  }
}
