import 'package:moneytree/data/local/database_constants.dart';
import 'package:moneytree/data/local/database_helper.dart';
import 'package:moneytree/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UsersTableManager {
  static final UsersTableManager instance = UsersTableManager._();

  UsersTableManager._();

  factory UsersTableManager() {
    return instance;
  }

  Future<int> addUser(UserModel user) async {
    var client = await DatabaseHelper.instance.db;
    if ((await fetchUser(user.id)) == null) {
      user.completed_chapter_id = '0';
      user.completed_per = '0';
      return client.insert(DatabaseTable.TABLE_USERS, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return 0;
    }
  }

  Future<int> updateUser(UserModel user) async {
    var client = await DatabaseHelper.instance.db;

    if ((await fetchUser(user.id)) == null) {
      user.completed_chapter_id = '0';
      return addUser(user);
    } else {
      return client.update(DatabaseTable.TABLE_USERS, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: '${DatabaseColumn.ID} = ?',
          whereArgs: [user.id]);
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_USERS);

    if (res.isNotEmpty) {
      var drawings =
      res.map((drawing) => UserModel.fromJson(drawing)).toList();
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<List<UserModel>> fetchUser(String id) async {
    print('fetch uid: $id');
    var client = await DatabaseHelper.instance.db;
    var res = await client.query(DatabaseTable.TABLE_USERS,
        where: '${DatabaseColumn.ID} = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      var drawings = res.map((drawing) => UserModel.fromJson(drawing)).toList();
      drawings.forEach((element) {
        print('data: ${element.toJson()}');
      });
      print("users size :: ${drawings.length}");
      return drawings;
    }
    return null;
  }

  Future<void> removeAllDrawings() async {
      var client = await DatabaseHelper.instance.db;
      return client.delete(DatabaseTable.TABLE_USERS);
    }
}
