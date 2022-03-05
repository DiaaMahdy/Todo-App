class Data {
  int? id;
  String? name;
  String? des;
  String? date;
  String? status;

  Data({this.id, this.name, this.des, this.date, this.status});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'des': des,
        'date': date,
        'status': status,
      };
}
