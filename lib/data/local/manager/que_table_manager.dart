import 'package:moneytree/data/local/database_constants.dart';
import 'package:moneytree/data/local/database_helper.dart';
import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class QueTableManger {
  static final QueTableManger instance = QueTableManger._();

  QueTableManger._();

  factory QueTableManger() {
    return instance;
  }

  Future<int> addQueWithResult(QueModel que) async {
    print(que.toJson());
    var client = await DatabaseHelper.instance.db;
    return client.insert(DatabaseTable.TABLE_QUE, que.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateDrawing(QueModel que) async {
    var client = await DatabaseHelper.instance.db;

    if ((await fetchQue(que.que_id, '')) == null) {
      return addQueWithResult(que);
    } else {
      return client.update(DatabaseTable.TABLE_QUE, que.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: '${DatabaseColumn.ID} = ?',
          whereArgs: [que.que_id]);
    }
  }

  Future<List<UserModel>> fetchAllDrawings() async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_QUE);

    if (res.isNotEmpty) {
      var drawings = res.map((drawing) => UserModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<List<QueModel>> fetchQue(String id, String userId) async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_QUE,
        where:
            '${DatabaseColumn.CHAPTER_ID} = ? and ${DatabaseColumn.USER_ID} = ?',
        whereArgs: [id, userId]);

    if (res.isNotEmpty) {
      var ques = res.map((drawing) => QueModel.fromJson(drawing)).toList();
      print("ques size :: ${ques.length}");
      return ques;
    }
    return null;
  }

  Future<int> deleteQue(String id, String userId) async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.delete(DatabaseTable.TABLE_QUE,
        where:
            '${DatabaseColumn.CHAPTER_ID} = ? and ${DatabaseColumn.USER_ID} = ?',
        whereArgs: [id, userId]);

    return res;
  }

  Future<void> removeAllDrawings() async {
    var client = await DatabaseHelper.instance.db;
    return client.delete(DatabaseTable.TABLE_USERS);
  }
}
