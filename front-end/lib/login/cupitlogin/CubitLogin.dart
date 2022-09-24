import 'package:agence/Api/constApi.dart';
import 'package:agence/Model/ErrorRegisterAndLoginModel.dart';
import 'package:agence/Model/LoginModel.dart';
import 'package:agence/Model/RegisterModel.dart';
import 'dart:convert' as convert;
import 'package:agence/login/cupitlogin/loginStates.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/httplaravel.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  Icon iconhidden = const Icon(Icons.visibility);

  LoginModel? loginModel;
  ErrorRegisterAndLoginModel? loginModelError;

  login({required Map<String, dynamic> data, required String path}) {
    emit(ConditionalLodinState());

    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;

        loginModel = LoginModel.fromJson(jsonResponse);
        print(loginModel!.token);
        TOKEN = loginModel!.token!;

        emit(GoodLoginState(loginModel));
      } else if (value.statusCode == 422) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;

        loginModelError = ErrorRegisterAndLoginModel.fromJson(jsonResponse);
        print(loginModelError!.message);
        emit(GoodLoginState(loginModelError));
      }
    }).catchError((error) {
      print(error.toString());
      emit(BadLoginState());
    });
  }

  RegisterModel? registerModel;
  ErrorRegisterAndLoginModel? errorRegisterModel;
  void registerUser(
      {required Map<String, dynamic> data, required String path}) {
    emit(ConditionalLodinState());
    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 201) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        registerModel = RegisterModel.fromJson(jsonResponse);
        TOKEN = registerModel!.token!;
        print(TOKEN);
        print(registerModel!.user!.name);

        emit(RegisterSuccesState(registerModel));
      } else if (value.statusCode == 422) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorRegisterModel = ErrorRegisterAndLoginModel.fromJson(jsonResponse);
        emit(RegisterSuccesState(errorRegisterModel));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterBadState());
    });
  }

  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(HiddenPasswordState());
  }

  bool typenumber = true;
  String path = LOGINCLIENT;
  void changetype(value) {
    typenumber = value;
    path = typenumber ? LOGINCLIENT : LOGINAGENCE;
    emit(ChangetypeState());
  }
}
