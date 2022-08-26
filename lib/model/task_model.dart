class TaskModel {
  String isLocked;
  String taskId;
  String uId;

  TaskModel({this.isLocked, this.taskId, this.uId});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      isLocked: json['isLocked'],
      taskId: json['taskId'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLocked'] = this.isLocked;
    data['taskId'] = this.taskId;
    data['uId'] = this.uId;
    return data;
  }
}
