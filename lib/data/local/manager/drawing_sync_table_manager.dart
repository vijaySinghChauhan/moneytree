import 'package:sqflite/sqlite_api.dart';

class DrawingSyncTableManager {
  static final DrawingSyncTableManager instance = DrawingSyncTableManager._();

  DrawingSyncTableManager._();

  factory DrawingSyncTableManager() {
    return instance;
  }

  // Add drawing
  // Future<int> addDrawingImage(DrawingData drawingData) async {
  //   var client = await DatabaseHelper.instance.db;
  //   return client.insert(
  //       DatabaseTable.TABLE_DRAWING_SYNC_TABLE, drawingData.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Update drawing
  // Future<int> updateDrawing(DrawingData drawingData) async {
  //   var client = await DatabaseHelper.instance.db;
  //
  //   if((await fetchDrawing(drawingData.id)) == null) {
  //     return addDrawingImage(drawingData);
  //   } else {
  //     return client.update(
  //         DatabaseTable.TABLE_DRAWING_SYNC_TABLE, drawingData.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //         where: '${DatabaseColumn.COLUMN_ID} = ?',
  //         whereArgs: [drawingData.id]);
  //   }
  // }

  // delete drawing
  // Future<int> deleteDrawing(DrawingData drawingData) async {
  //   var client = await DatabaseHelper.instance.db;
  //   return client.delete(DatabaseTable.TABLE_DRAWING_SYNC_TABLE,
  //       where: '${DatabaseColumn.COLUMN_ID} = ?', whereArgs: [drawingData.id]);
  // }

  // Get All data
  // Future<List<DrawingData>> fetchAllDrawings() async {
  //   var client = await DatabaseHelper.instance.db;
  //   var res = await client.query(DatabaseTable.TABLE_DRAWING_SYNC_TABLE);
  //
  //   if (res.isNotEmpty) {
  //     var drawings =
  //         res.map((drawing) => DrawingData.fromJson(drawing)).toList();
  //     print("drawings size :: ${drawings.length}");
  //     return drawings;
  //   }
  //   return null;
  // }
  //
  // // Get All data
  // Future<List<DrawingData>> fetchDrawing(String id) async {
  //   var client = await DatabaseHelper.instance.db;
  //   var res = await client.query(DatabaseTable.TABLE_DRAWING_SYNC_TABLE,
  //       where: '${DatabaseColumn.COLUMN_ID} = ?', whereArgs: [id]);
  //
  //   if (res.isNotEmpty) {
  //     var drawings =
  //         res.map((drawing) => DrawingData.fromJson(drawing)).toList();
  //     print("drawings size :: ${drawings.length}");
  //     return drawings;
  //   }
  //   return null;
  // }
  //
  // // Remove all Drawing
  // Future<void> removeAllDrawings() async {
  //   var client = await DatabaseHelper.instance.db;
  //   return client.delete(DatabaseTable.TABLE_DRAWING_SYNC_TABLE);
  // }
}
