class User {
  int id;
  String name;
  String phoneNumber;
  String description;
  User({this.id, this.name, this.phoneNumber, this.description});
  User.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.phoneNumber = map['phoneNumber'];
    this.description = map['description'];
  }

  Map<String, dynamic> toJson() =>
      {'name': name,
       'phoneNumber': phoneNumber,
       'description': description};
}
