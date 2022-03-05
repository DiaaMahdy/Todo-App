class UserModel {
  String? uID;
  String? name;
  String? email;
  String? phone;

  UserModel({
    this.uID,
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
