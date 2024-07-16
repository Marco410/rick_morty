import 'package:sqflite/sqflite.dart';

import '../../config/DB/database.dart';
import '../../config/constants/constants.dart';
import '../models/models.dart';

class CharacterController {
  ///Function to insert character into database
  static Future<void> insertViewCharacter(Character character) async {
    final databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;

    List<Map> list = await database.rawQuery(
        'SELECT * FROM $tableLastViews WHERE character_id = ${character.id};');
    List<Map> listAll = await getCharactersViews();

    ///case when list of characters is full
    ///The last character should be deleted
    if (listAll.length == 5) {
      final ch = listAll.where((c) => c['character_id'] == character.id);

      ///case if character is inside this list
      if (ch.isNotEmpty) {
        deleteCharacter(ch.first['id'].toString());
        insertValue(character);

        ///case if character is not inside this list
      } else {
        deleteCharacter(listAll[4]['id'].toString());
        insertValue(character);
      }
    } else {
      ///case if character not belongs to first list
      if (list.isEmpty) {
        insertValue(character);

        ///case if character belongs to first list
      } else {
        deleteCharacter(list[0]['id'].toString());
        insertValue(character);
      }
    }
  }

  ///Function to get list of characters seen
  static Future<List<Map>> getCharactersViews() async {
    var databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;
    List<Map> list = await database
        .rawQuery('SELECT * FROM $tableLastViews ORDER BY id DESC LIMIT 5;');
    return list;
  }

  ///Function to delete character from database
  static deleteCharacter(String id) async {
    var databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    batch.delete(tableLastViews, where: 'id = ?', whereArgs: [id]);
    batch.commit();
  }

  ///Function to insert character
  static insertValue(Character character) async {
    final databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    batch.insert(tableLastViews, {
      'character_id': character.id,
      'name': character.name,
      'status': character.status.name,
      'type': character.type,
      'species': character.species,
      'gender': character.gender,
      'image': character.image,
      'originName': character.origin.name,
      'originUrl': character.origin.url,
      'locationName': character.location.name,
      'locationUrl': character.location.url,
    });
    batch.commit();
  }
}
