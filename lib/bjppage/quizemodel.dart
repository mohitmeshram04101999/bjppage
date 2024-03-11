class QuizModel {
  String message;
  bool success;
  List<Quistion> data;

  QuizModel({
    required this.message,
    required this.success,
    required this.data,
  });

}

class Quistion {
  int id;
  int quizId;
  String question;
  String a;
  String b;
  String c;
  String d;
  String correctAnswer;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userAnswer;
  bool quizStatus;
  bool userAnswerStatus;

  Quistion({
    required this.id,
    required this.quizId,
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correctAnswer,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.userAnswer,
    required this.quizStatus,
    required this.userAnswerStatus,
  });

  factory Quistion.fromMap(Map<String,dynamic> data)
  {
    int _id = data["id"];
    print("1");

    int _quizId = data["quiz_id"];
    print("2");

    String _question = data["question"];
    print("3");

    String _a = data["a"];
    print("4");

    String _b = data["b"];
    print("5");

    String _c = data["c"];
    print("6");

    String _d = data["d"];
    print("7");

    String _correctAnswer = data["correct_answer"];
    print("8");

    int _status = data["status"];
    print("9");

    dynamic _createdAt = data["created_at"];
    print("10");

    dynamic _updatedAt = data["updated_at"];
    print("11");

    dynamic _userAnswer = data["user_answer"];
    print("12");

    bool _quizStatus = data["quiz_status"];
    print("13");

    bool _userAnswerStatus = data["user_answer_status"];
    print("14");


    return Quistion(
        id: _id,
        quizId: _quizId,
        question: _question,
        a: _a,
        b: _b,
        c: _c,
        d: _d,
        correctAnswer: _correctAnswer,
        status: _status,
        quizStatus: _quizStatus,
        createdAt: _createdAt,
        updatedAt: _updatedAt,
        userAnswer: _userAnswer,
        userAnswerStatus: _userAnswerStatus);

  }

  Map<String,dynamic> toMap()
  {
    return {
      "id": id,
      "quiz_id": quizId,
      "question": question,
      "a": a,
      "b": b,
      "c": c,
      "d": d,
      "correct_answer": correctAnswer,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "user_answer": userAnswer,
      "quiz_status": quizStatus,
      "user_answer_status": userAnswerStatus
    };
  }


}
