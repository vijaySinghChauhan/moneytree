class QueModel {
  String que_id;
  String chapter_id;
  String chapter_name;
  String que;
  String que_type;
  String ans;
  String selected_ans;
  String result;
  String rank_a;
  String rank_b;
  String rank_c;
  String rank_d;
  String option_a;
  String option_b;
  String option_c;
  String option_d;
  String option_e;
  String option_f;
  String option_g;
  String option_h;
  String option_i;
  String option_j;
  String option_k;
  String userId;
  String blank1;
  String blank2;
  String blank3;
  String part1;
  String part2;
  String part3;

  QueModel({
    this.que_id,
    this.chapter_id,
    this.chapter_name,
    this.que,
    this.que_type,
    this.ans,
    this.selected_ans,
    this.result,
    this.rank_a,
    this.rank_b,
    this.rank_c,
    this.rank_d,
    this.option_a,
    this.option_b,
    this.option_c,
    this.option_d,
    this.option_e,
    this.option_f,
    this.option_g,
    this.option_h,
    this.option_i,
    this.option_j,
    this.option_k,
    this.userId,
    this.blank1,
    this.blank2,
    this.blank3,
    this.part1,
    this.part2,
    this.part3,
  });

  factory QueModel.fromJson(Map<String, dynamic> json) {
    return QueModel(
        que_id: json['que_id'],
        chapter_id: json['chapter_id'],
        chapter_name: json['chapter_name'],
        que: json['que'],
        que_type: json['que_type'],
        ans: json['ans'],
        selected_ans: json['selected_ans'],
        result: json['result'],
        rank_a: json['rank_a'],
        rank_b: json['rank_b'],
        rank_c: json['rank_c'],
        rank_d: json['rank_d'],
        option_a: json['option_a'],
        option_b: json['option_b'],
        option_c: json['option_c'],
        option_d: json['option_d'],
        option_e: json['option_e'],
        option_f: json['option_f'],
        option_g: json['option_g'],
        option_h: json['option_h'],
        option_i: json['option_i'],
        option_j: json['option_j'],
        option_k: json['option_k'],
        userId: json['userId'],
        blank1: json['blank1'],
        blank2: json['blank2'],
        blank3: json['blank3'],
        part1: json['part1'],
        part2: json['part2'],
        part3: json['part3']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['que_id'] = this.que_id;
    data['chapter_id'] = this.chapter_id;
    data['chapter_name'] = this.chapter_name;
    data['que'] = this.que;
    data['que_type'] = this.que_type;
    data['ans'] = this.ans;
    data['selected_ans'] = this.selected_ans;
    data['result'] = this.result;
    data['rank_a'] = this.rank_a;
    data['rank_b'] = this.rank_b;
    data['rank_c'] = this.rank_c;
    data['rank_d'] = this.rank_d;
    data['option_a'] = this.option_a;
    data['option_b'] = this.option_b;
    data['option_c'] = this.option_c;
    data['option_d'] = this.option_d;
    data['option_e'] = this.option_e;
    data['option_f'] = this.option_f;
    data['option_g'] = this.option_g;
    data['option_h'] = this.option_h;
    data['option_i'] = this.option_i;
    data['option_j'] = this.option_j;
    data['option_k'] = this.option_k;
    data['userId'] = this.userId;
    data['blank1'] = this.blank1;
    data['blank2'] = this.blank2;
    data['blank3'] = this.blank3;
    data['part1'] = this.part1;
    data['part2'] = this.part2;
    data['part3'] = this.part3;
    return data;
  }
}
