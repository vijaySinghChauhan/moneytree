import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/utils/strings.dart';

class ChapterModel {
  String chapter_id;
  String chapter_name;
  String icon;
  List<QueModel> queList;
  List<String> tasks;

  ChapterModel({this.chapter_id, this.chapter_name, this.queList, this.tasks, this.icon});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    if (json['queList'] != null) {
      queList = new List<QueModel>();
      json['image_data'].forEach((v) {
        queList.add(new QueModel.fromJson(v));
      });
    }
    if (json['tasks'] != null) {
      tasks = new List<String>();
      json['tasks'].forEach((v) {
        tasks.add(v);
      });
    }
    chapter_id = json['chapter_id'];
    chapter_name = json['chapter_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapter_id;
    data['chapter_name'] = this.chapter_name;
    return data;
  }

  Map<String, dynamic> toJsonWithQue() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapter_id;
    data['chapter_name'] = this.chapter_name;
    data['queList'] = this.queList.map((v) => v.toJson()).toList();
    data['tasks'] = this.tasks.map((v) => v).toList();
    return data;
  }
}
