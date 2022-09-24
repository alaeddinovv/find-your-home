class DataOffer {
  DataOfferModel? data;
  DataOffer.fromJson(Map<String, dynamic> json) {
    data = DataOfferModel.fromJson(json['data']);
  }
}

class DataOfferModel {
  List<OffersModel> offers = [];
  DataOfferModel.fromJson(Map<String, dynamic> json) {
    json['offers'].forEach((element) {
      offers.add(OffersModel.fromJson(element));
    });
  }
}

class OffersModel {
  int? id;
  int? agenceId;
  String? typeVente;
  String? address;
  String? description;
  int? price;
  int? space;
  int? nEtage;
  int? nChambre;
  String? wilaya;
  List? photo;
  String? typeOffer;
  List? conditionDePaiment;
  List? specification;
  List? papiers;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agenceId = json['agence_id'];
    typeVente = json['type_vente'];
    address = json['address'];
    description = json['description'];
    price = json['price'];
    space = json['space'];
    nEtage = json['n_etage'];
    nChambre = json['n_chambre'];
    wilaya = json['wilaya'];
    photo = json['photo'];
    typeOffer = json['type_offer'];
    conditionDePaiment = json['condition_de_paiment'];
    specification = json['specification'];
    papiers = json['papiers'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
