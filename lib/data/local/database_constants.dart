abstract class DatabaseConstant {
  // Database details
  static const DATABASE_NAME = "duppy.db";
  static const DATABASE_VERSION = 1;
}

abstract class DatabaseQuery {
  // Database create query's
  static const CREATE_USERS_TABLE = '''
      CREATE TABLE ${DatabaseTable.TABLE_USERS}(
        ${DatabaseColumn.USER_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseColumn.ID} TEXT,
        ${DatabaseColumn.FIRST_NAME} TEXT,
        ${DatabaseColumn.LAST_NAME} TEXT,
        ${DatabaseColumn.MOBILE} TEXT,
        ${DatabaseColumn.PASSWORD} TEXT,
        ${DatabaseColumn.COMPLETED_CHAPTER_ID} TEXT,
        ${DatabaseColumn.EMAIL} TEXT,
        ${DatabaseColumn.COMPLETED_PER} TEXT)
    ''';

  static const CREATE_CHAPTER_TABLE = '''
      CREATE TABLE ${DatabaseTable.TABLE_CHAPTER}(
        ${DatabaseColumn.CHAPTER_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseColumn.CHAPTER_NAME} TEXT)
    ''';

  static const CREATE_RESULT_TABLE =
      '''CREATE TABLE ${DatabaseTable.TABLE_RESULT}(${DatabaseColumn.CHAPTER_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseColumn.CHAPTER_NAME} TEXT,${DatabaseColumn.RESULT} TEXT,${DatabaseColumn.USER_ID} TEXT)''';

  static const CREATE_QUE_TABLE = '''
      CREATE TABLE ${DatabaseTable.TABLE_QUE}(
        ${DatabaseColumn.ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseColumn.QUE_ID} TEXT,
        ${DatabaseColumn.CHAPTER_ID} TEXT,
        ${DatabaseColumn.CHAPTER_NAME} TEXT,
        ${DatabaseColumn.QUE} TEXT,
        ${DatabaseColumn.QUE_TYPE} TEXT,
        ${DatabaseColumn.ANS} TEXT,
        ${DatabaseColumn.SELECTED_ANS} TEXT,
        ${DatabaseColumn.RESULT} TEXT,
        ${DatabaseColumn.RANK_A} TEXT,
        ${DatabaseColumn.RANK_B} TEXT,
        ${DatabaseColumn.RANK_C} TEXT,
        ${DatabaseColumn.RANK_D} TEXT,
        ${DatabaseColumn.OPTION_A} TEXT,
        ${DatabaseColumn.OPTION_B} TEXT,
        ${DatabaseColumn.OPTION_C} TEXT,
        ${DatabaseColumn.OPTION_D} TEXT,
        ${DatabaseColumn.OPTION_E} TEXT,
        ${DatabaseColumn.OPTION_F} TEXT,
        ${DatabaseColumn.OPTION_G} TEXT,
        ${DatabaseColumn.OPTION_H} TEXT,
        ${DatabaseColumn.OPTION_I} TEXT,
        ${DatabaseColumn.OPTION_J} TEXT,
        ${DatabaseColumn.OPTION_K} TEXT,
        ${DatabaseColumn.PART_1} TEXT,
        ${DatabaseColumn.PART_2} TEXT,
        ${DatabaseColumn.PART_3} TEXT,
        ${DatabaseColumn.BLANK_1} TEXT,
        ${DatabaseColumn.BLANK_2} TEXT,
        ${DatabaseColumn.BLANK_3} TEXT,
        ${DatabaseColumn.USER_ID} TEXT)
    ''';

  static const ORDER_BY_CHAPTER_NAME = '''${DatabaseColumn.CHAPTER_NAME} ASC''';

//  static const ORDER_BY_TEAM_NAME =
//      '''${DatabaseColumn.COLUMN_TEAM_NAME} ASC''';
//  static const ORDER_BY_ASST_COACH_NAME =
//      '''${DatabaseColumn.COLUMN_ASST_COACH_FIRST_NAME} ASC, ${DatabaseColumn.COLUMN_ASST_COACH_LAST_NAME} ASC''';
}

abstract class DatabaseTable {
  // Database tables
  static const TABLE_USERS = "users";
  static const TABLE_CHAPTER = "chapter";
  static const TABLE_RESULT = "result";
  static const TABLE_QUE = "que";
}

abstract class DatabaseColumn {
  // Database common columns
  static const USER_ID = "userId";
  static const EMAIL = "email";
  static const FIRST_NAME = "first_name";
  static const LAST_NAME = "last_name";
  static const MOBILE = "mobile";
  static const PASSWORD = "password";
  static const COMPLETED_CHAPTER_ID = "completed_chapter_id";
  static const COMPLETED_PER = "completed_per";
  static const ID = "id";

  static const CHAPTER_NAME = "chapter_name";
  static const CHAPTER_ID = "chapter_id";
  static const QUE_ID = "que_id";
  static const QUE = "que";
  static const QUE_TYPE = "que_type";
  static const ANS = "ans";
  static const SELECTED_ANS = "selected_ans";
  static const RESULT = "result";
  static const RANK_A = "rank_a";
  static const RANK_B = "rank_b";
  static const RANK_C = "rank_c";
  static const RANK_D = "rank_d";
  static const OPTION_A = "option_a";
  static const OPTION_B = "option_b";
  static const OPTION_C = "option_c";
  static const OPTION_D = "option_d";
  static const OPTION_E = "option_e";
  static const OPTION_F = "option_f";
  static const OPTION_G = "option_g";
  static const OPTION_H = "option_h";
  static const OPTION_I = "option_i";
  static const OPTION_J = "option_j";
  static const OPTION_K = "option_k";
  static const BLANK_1 = "blank1";
  static const BLANK_2 = "blank2";
  static const BLANK_3 = "blank3";
  static const PART_1 = "part1";
  static const PART_2 = "part2";
  static const PART_3 = "part3";
}
