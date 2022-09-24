import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Api/constApi.dart';
import '../Api/httplaravel.dart';
import '../Model/AfficheOffer.dart';
import 'CubitOfferDetailState.dart';

class CubitDetail extends Cubit<DetailStates> {
  CubitDetail() : super(InitialDetailState());
  static CubitDetail get(context) => BlocProvider.of(context);
  LatLng? currentLocation;

  int indexAgence = 0;
  int indexClient = 0;

  void changeNavDetailAgence(int index) {
    indexAgence = index;
    emit(DeclarIndexState());
  }

  void changeNavDetailClient(int index) {
    indexClient = index;
    emit(DeclarIndexState());
  }

  DataOffer? getFavoritesmodel;
  Future<void> getFavorites() async {
    getFavoritesmodel = null;
    emit(ConditionalLodinGetFavoritesState());
    await Httplar.httpget(path: GETALLFAVORITE).then((value) {
      var jsonResponse = convert.jsonDecode(value.body) as Map<String, dynamic>;

      getFavoritesmodel = DataOffer.fromJson(jsonResponse);
      print('ook get favorites');
      emit(GoodGetFavorites());
    }).catchError((e) {
      print(e.toString());
      print('majebt walo fav');
      emit(BadGetFavorites());
    });
  }

  Future<void> deletOffer({required Map<String, dynamic> data}) async {
    emit(LodinDeleteOffer());
    await Httplar.httpPost(data: data, path: DELETEOFFER).then((value) {
      print('Good Delete');
      emit(GoodDeleteOffersState());
    }).catchError((e) {
      print(e.toString());
      emit(BadDeleteOffersState());
    });
  }

//-----------------------------------------favorite--------------------------------------------
  bool colorfav = false;
  var existfav;
  getexistfav({
    required Map<String, dynamic> data,
  }) {
    emit(LoadingExFavState());

    Httplar.httpPost(path: CHECKFAVORITE, data: data).then((value) async {
      existfav = null;
      print('dkholt l verifier favoris');
      if (value.statusCode == 200) {
        var jsonResponse = jsonDecode(value.body);
        print(jsonResponse);

        print('ryh nrodu true');
        await Future.delayed(Duration(seconds: 1));
        existfav = jsonResponse;
        colorfav = true;

        emit(GoodGetFavState());
      } else if (value.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        print('ryh nrodu false');
        await Future.delayed(Duration(seconds: 1));
        existfav = jsonResponse;
        colorfav = false;

        emit(GoodGetFavState());
      }
    }).catchError((error) {
      print('ki l3ada erreur');

      emit(BaadGetFavState());
    });
  }

  Future<void> changefav({required Map<String, dynamic> data, bool? dd}) async {
    emit(LoadingChangeFavState());
    if (dd == true) {
      print('true');

      await Httplar.httpdelete(path: CHANGEFAVTOFALSE, data: data)
          .then((value) {
        colorfav = false;
        emit(GoodChangeFavoriteState());
      }).catchError((error) {
        print(error.toString());
        emit(BadChangeFavoriteState());
      });
    } else if (dd == false) {
      print('false');
      Httplar.httpPost(path: CHANGEFAVTOTRUE, data: data).then((value) {
        colorfav = true;
        emit(GoodChangeFavoriteState());
      }).catchError((error) {
        print(error.toString());

        emit(BadChangeFavoriteState());
      });
    }
  }

// ------------------------------------------------------------------------------------

//----------------------messages--------------------------------------------------------

  Future<void> sendMessage({required Map<String, dynamic> data}) async {
    await Httplar.httpPost(data: data, path: SENDMESSAGE).then((value) {
      print('succes msg send');
      print(value.body);
      emit(GoodSendMsgState());
    }).catchError((e) {
      print(e.toString());
      emit(BadSendMsgState());
    });
  }

  var allmsgmodel;
  Future<void> getAllMsg({required Map<String, dynamic> data}) async {
    emit(LodinGetAllMsgOfferState());
    await Httplar.httpPost(data: data, path: GETALLMSG).then((value) {
      var jsonResponse = convert.jsonDecode(value.body);
      allmsgmodel = jsonResponse;
      print(allmsgmodel);
      emit(GoodGetAllMsgState());
    }).catchError((e) {
      print(e.toString());
      emit(BadGetAllMsgState());
    });
  }

  Future<void> deleteMsg({required Map<String, dynamic> data}) async {
    emit(LodinDeleteMsgOfferState());
    await Httplar.httpPost(data: data, path: DELETEMSGOFFER).then((value) {
      print('tna7a msg');
      emit(GoodDeleteMsgState());
    }).catchError((e) {
      print(e.toString());

      print('ma7abch ytna7a msg');
      emit(BadDeleteMsgOfferState());
    });
  }

  var namAndphoen;
  Future<void> getNameandPhone({required Map<String, dynamic> data}) async {
    emit(LodinNamAndPhoneState());

    await Httplar.httpPost(data: data, path: GETPHONEAGENCE).then((value) {
      var jsonResponse = convert.jsonDecode(value.body);
      namAndphoen = jsonResponse;
      print(namAndphoen);

      print('get num and phone Good ');

      emit(GoodNamAndPhoneState());
    }).catchError((e) {
      print(e.toString());
      print('oooooooooooooo kyn mochkol phone');
      emit(BadNamAndPhoneState());
    });
  }
}

class Conditions_paiment {
  final int id;
  final String name;

  Conditions_paiment({
    required this.id,
    required this.name,
  });
}

class Specefication {
  final int id;
  final String name;

  Specefication({
    required this.id,
    required this.name,
  });
}

class Papiers {
  final int id;
  final String name;

  Papiers({
    required this.id,
    required this.name,
  });
}
