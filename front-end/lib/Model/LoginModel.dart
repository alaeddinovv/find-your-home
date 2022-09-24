class LoginModel {
  int? id;
  String? name;
  String? email;
  String? token;
  String? phone;
  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
  }
}
