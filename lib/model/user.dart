class User {
  String? username;
  String? email;
  String? tel;
  String? address;
  String? password;

  User({this.username, this.email, this.tel, this.address, this.password});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    tel = json['tel'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['address'] = this.address;
    data['password'] = this.password;
    return data;
  }
}
