import 'package:sqflite/sqflite.dart';

import '../../config/DB/database.dart';
import '../../config/constants/constants.dart';
import '../models/models.dart';

class CharacterController {
  static Future<void> insertViewCharacter(Character character) async {
    final databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;

    List<Map> list = await database.rawQuery(
        'SELECT * FROM $tableLastViews WHERE character_id = ${character.id};');
    List<Map> listAll = await getCharactersViews();
    if (listAll.length == 5) {
      final ch = listAll.where((c) => c['character_id'] == character.id);

      if (ch.isNotEmpty) {
        deleteCharacter(ch.first['id'].toString());
        insertValue(character);
      } else {
        deleteCharacter(listAll[4]['id'].toString());
        insertValue(character);
      }
    } else {
      if (list.isEmpty) {
        insertValue(character);
      } else {
        deleteCharacter(list[0]['id'].toString());
        insertValue(character);
      }
    }
  }

  static Future<List<Map>> getCharactersViews() async {
    var databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;
    List<Map> list = await database
        .rawQuery('SELECT * FROM $tableLastViews ORDER BY id DESC LIMIT 5;');
    return list;
  }

  static deleteCharacter(String id) async {
    var databaseFuture = DatabaseHelper.db.database;
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    batch.delete(tableLastViews, where: 'id = ?', whereArgs: [id]);
    batch.commit();
  }

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
