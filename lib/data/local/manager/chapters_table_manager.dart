import 'package:moneytree/data/local/database_constants.dart';
import 'package:moneytree/data/local/database_helper.dart';
import 'package:moneytree/model/result_model.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class ChaptersTableManager {
  static final ChaptersTableManager instance = ChaptersTableManager._();

  ChaptersTableManager._();

  factory ChaptersTableManager() {
    return instance;
  }

  Future<int> addDrawingImage(UserModel user) async {
    var client = await DatabaseHelper.instance.db;
    return client.insert(DatabaseTable.TABLE_USERS, user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateDrawing(UserModel user) async {
    var client = await DatabaseHelper.instance.db;

    if ((await fetchDrawing(user.id)) == null) {
      return addDrawingImage(user);
    } else {
      return client.update(DatabaseTable.TABLE_USERS, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: '${DatabaseColumn.ID} = ?',
          whereArgs: [user.id]);
    }
  }

  Future<List<UserModel>> fetchAllDrawings() async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_USERS);

    if (res.isNotEmpty) {
      var drawings = res.map((drawing) => UserModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<List<UserModel>> fetchDrawing(String id) async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_USERS,
        where: '${DatabaseColumn.ID} = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      var drawings = res.map((drawing) => UserModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<void> removeAllDrawings() async {
    var client = await DatabaseHelper.instance.db;
    return client.delete(DatabaseTable.TABLE_USERS);
  }

  Future<int> addChapterResult(ResultModel result) async {
    var client = await DatabaseHelper.instance.db;
    return client.insert(DatabaseTable.TABLE_RESULT, result.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ResultModel>> fetchAllChapterResult() async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_RESULT);

    if (res.isNotEmpty) {
      var drawings =
          res.map((drawing) => ResultModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<List<ResultModel>> fetchChapterResult(String id, String userId) async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_RESULT,
        where: '${DatabaseColumn.CHAPTER_ID} = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      var drawings =
          res.map((drawing) => ResultModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<void> removeChapterResult(String id) async {
    var client = await DatabaseHelper.instance.db;
    for( var i = int.parse(id) ; i <= 10; i++ ) {
      await client.delete(DatabaseTable.TABLE_RESULT,
          where: '${DatabaseColumn.CHAPTER_ID} = ?', whereArgs: [i.toString()]);
    }
  }
}
