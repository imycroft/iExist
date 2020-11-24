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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['id'] = this.id;
    map['name'] = this.name;
    map['phoneNumber'] = this.phoneNumber;
    map['description'] = this.description;
    return map;
  }
}
