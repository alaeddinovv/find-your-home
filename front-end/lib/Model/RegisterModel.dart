class RegisterModel {
  String? token;

  UserModel? user;
  AgenceModel? agence;
  ClientModel? client;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];

    user = UserModel.fromJson(json['user']);
    agence =
        json['agence'] != null ? AgenceModel.fromJson(json['agence']) : null;
    client =
        json['client'] != null ? ClientModel.fromJson(json['client']) : null;
  }
}

class UserModel {
  String? name;
  String? email;
  String? phone;
  int? id;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }
}

class AgenceModel {
  String? address;
  int? user_id;
  int? id;

  AgenceModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    user_id = json['user_id'];
    id = json['id'];
  }
}

class ClientModel {
  String? prenom;
  int? user_id;
  int? id;
  ClientModel.fromJson(Map<String, dynamic> json) {
    prenom = json['prenom'];
    user_id = json['user_id'];
    id = json['id'];
  }
}
