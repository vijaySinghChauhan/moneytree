class ResultModel {
    int chapter_id;
    String chapter_name;
    String userId;
    String result;

    ResultModel({this.chapter_id, this.chapter_name, this.result,this.userId});

    factory ResultModel.fromJson(Map<String, dynamic> json) {
        return ResultModel(
            chapter_id: json['chapter_id'],
            chapter_name: json['chapter_name'],
            userId: json['userId'],
            result: json['result'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chapter_id'] = this.chapter_id;
        data['chapter_name'] = this.chapter_name;
        data['userId'] = this.userId;
        data['result'] = this.result;
        return data;
    }
}