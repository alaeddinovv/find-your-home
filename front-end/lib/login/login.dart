import 'package:agence/Model/ErrorRegisterAndLoginModel.dart';
import 'package:agence/Model/LoginModel.dart';
import 'package:agence/clienthome/navbar.dart';

import 'package:agence/login/ChooseRegister.dart';
import 'package:agence/login/other/cachhelper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';

import '../Api/constApi.dart';

import '../home/home.dart';
import '../shared/components/components.dart';
import 'cupitlogin/CubitLogin.dart';
import 'cupitlogin/loginStates.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();

  Map<String, dynamic> sendinfologin = {};
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'login now to browse our hot offers',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: CupitHome.get(context).dartSwitch
                                          ? const Color(0xff131313)
                                          : Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    color: LoginCubit.get(context).typenumber
                                        ? CupitHome.get(context).dartSwitch
                                            ? const Color(0xff131313)
                                            : Colors.blue
                                        : CupitHome.get(context).dartSwitch
                                            ? Colors.blueGrey
                                            : Colors.white70,
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.transparent,
                                    highlightColor:
                                        CupitHome.get(context).dartSwitch
                                            ? Colors.transparent
                                            : Colors.transparent,
                                    child: Text(
                                      'CLIENT',
                                      style: TextStyle(
                                        color: LoginCubit.get(context)
                                                .typenumber
                                            ? CupitHome.get(context).dartSwitch
                                                ? Colors.white
                                                : Colors.white
                                            : CupitHome.get(context).dartSwitch
                                                ? Colors.white
                                                : Colors.blue,
                                      ),
                                    ),
                                    onPressed: () {
                                      LoginCubit.get(context).changetype(true);
                                      print(LoginCubit.get(context).path);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: CupitHome.get(context).dartSwitch
                                          ? const Color(0xff131313)
                                          : Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    color: !LoginCubit.get(context).typenumber
                                        ? CupitHome.get(context).dartSwitch
                                            ? const Color(0xff131313)
                                            : Colors.blue
                                        : CupitHome.get(context).dartSwitch
                                            ? Colors.blueGrey
                                            : Colors.white70,
                                  ),
                                  child: MaterialButton(
                                    highlightColor:
                                        CupitHome.get(context).dartSwitch
                                            ? Colors.blueGrey
                                            : Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Text(
                                      'AGENCE',
                                      style: TextStyle(
                                        color: !LoginCubit.get(context)
                                                .typenumber
                                            ? CupitHome.get(context).dartSwitch
                                                ? Colors.white
                                                : Colors.white
                                            : CupitHome.get(context).dartSwitch
                                                ? Colors.white
                                                : Colors.blue,
                                      ),
                                    ),
                                    onPressed: () {
                                      LoginCubit.get(context).changetype(false);
                                      print(LoginCubit.get(context).path);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      defaultForm(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: Text(
                            'Email',
                            style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Email Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: Icon(
                            Icons.email,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultForm(
                          context: context,
                          textInputAction: TextInputAction.done,
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          onFieldSubmitted: () {
                            if (formKey.currentState!.validate()) {
                              sendinfologin = {
                                'email': emailController.text,
                                'password': passController.text
                              };
                              LoginCubit.get(context).login(
                                  data: sendinfologin,
                                  path: LoginCubit.get(context).path);
                            }
                          },
                          obscureText: LoginCubit.get(context).ishidden,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password Must Be Not Empty';
                            }
                          },
                          lable: Text(
                            'Password',
                            style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          ),
                          sufixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).showpass();
                            },
                            icon: LoginCubit.get(context).iconhidden,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          )),
                      const SizedBox(
                        height: 18,
                      ),
                      ConditionalBuilder(
                        condition: state is! ConditionalLodinState,
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CupitHome.get(context).dartSwitch
                                  ? Colors.blueGrey
                                  : Colors.blue,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(15)),
                            ),
                            child: Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                width: double.infinity,
                                child: MaterialButton(
                                  highlightColor:
                                      CupitHome.get(context).dartSwitch
                                          ? Colors.blueGrey
                                          : Colors.blue,
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      sendinfologin = {
                                        'email': emailController.text,
                                        'password': passController.text
                                      };
                                      LoginCubit.get(context).login(
                                          data: sendinfologin,
                                          path: LoginCubit.get(context).path);
                                    }
                                    print(LoginCubit.get(context).path);
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'dont have account?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Chooseregister()));
                              },
                              child: const Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GoodLoginState) {
          if (state.model is ErrorRegisterAndLoginModel) {
            Fluttertoast.showToast(
                msg: state.model!.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state.model is LoginModel) {
            CachHelper.putcache(key: 'token', value: state.model!.token)
                .then((value) async {
              await CachHelper.putcache(
                  key: 'userType', value: LoginCubit.get(context).path);
              await CupitHome.get(context).getinformationAgenceOrClient();

              if (LoginCubit.get(context).path == LOGINCLIENT) {
                CupitHome.get(context).currentindexa = 0;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Navbar()),
                    (route) => false);
                await CupitHome.get(context).getTypeOffer(
                    type: '/' +
                        CupitHome.get(context)
                            .type_vente[CupitHome.get(context).toggelindex]);
                // await CubitDetail.get(context).getFavorites();
              } else if (LoginCubit.get(context).path == LOGINAGENCE) {
                CupitHome.get(context).currentindex = 0;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false);
                await CupitHome.get(context).getOfferAgence();
              }
            });
            Fluttertoast.showToast(
                msg: 'Welcome ${state.model!.name}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else if (state is BadLoginState) {
          Fluttertoast.showToast(
              msg: 'unable to connect',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }
}
