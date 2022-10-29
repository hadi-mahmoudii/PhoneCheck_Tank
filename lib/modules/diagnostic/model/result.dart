class Result {
  int id;
  String grade;
  String info;
  String status;

  Result({this.grade, this.info, this.status});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grade = json['grade'];
    info = json['info'];
    status = json['status'];
  }
}
