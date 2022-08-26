class UserModel {
  String email;
  String first_name;
  String id;
  int userId;
  String last_name;
  String mobile;
  String completed_chapter_id;
  String completed_per;

  UserModel({this.email, this.first_name, this.id, this.userId, this.last_name, this.mobile, this.completed_chapter_id, this.completed_per});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        first_name: json['first_name'],
        id: json['id'],
      userId: json['userId'],
        last_name: json['last_name'],
      mobile: json['mobile'],
      completed_chapter_id: json['completed_chapter_id'],
      completed_per: json['completed_per'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['last_name'] = this.last_name;
    data['mobile'] = this.mobile;
    data['completed_chapter_id'] = this.completed_chapter_id;
    data['completed_per'] = this.completed_per;
    return data;
  }
}
