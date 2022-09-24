class Dd {
  List<Name> o = [];
  Dd.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      o.add(Name.fromJson(element));
    });
  }
}

class Name {
  String? name;
  String? phone;
  int? agenceId;
  String? photo;

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    agenceId = json['id'];
    photo = json['photo'];
  }
}
