class GetInfoUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  AgenceModel? agence;
  ClientModel? client;
  GetInfoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];

    agence =
        json['agence'] != null ? AgenceModel.fromJson(json['agence']) : null;
    client =
        json['client'] != null ? ClientModel.fromJson(json['client']) : null;
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
