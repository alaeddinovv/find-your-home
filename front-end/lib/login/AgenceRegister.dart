import 'package:agence/Api/constApi.dart';
import 'package:agence/Model/ErrorRegisterAndLoginModel.dart';
import 'package:agence/Model/RegisterModel.dart';
import 'package:agence/home/home.dart';
import 'package:agence/login/cupitlogin/loginStates.dart';
import 'package:agence/login/login.dart';
import 'package:agence/login/other/cachhelper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';

import '../shared/components/components.dart';
import 'cupitlogin/CubitLogin.dart';

class Agenceregister extends StatelessWidget {
  Agenceregister({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var addresseController = TextEditingController();
  var prenomController = TextEditingController();

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var numberController = TextEditingController();
  Map<String, dynamic> sendinfoagence = {};
  var formKeyyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKeyyy,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        defaultForm(
                            context: context,
                            controller: nameController,
                            type: TextInputType.text,
                            lable: Text(
                              'nom',
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'name Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: Icon(
                              Icons.person,
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
                            controller: addresseController,
                            type: TextInputType.text,
                            lable: Text(
                              'addresse',
                              style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'addresse Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: Icon(
                              Icons.place,
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
                            onFieldSubmitted: () {},
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
                        defaultForm(
                          context: context,
                          controller: numberController,
                          type: TextInputType.number,
                          lable: Text(
                            'number',
                            style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'number Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: Icon(
                            Icons.phone,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
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
                                      if (formKeyyy.currentState!.validate()) {
                                        sendinfoagence = {
                                          'name': nameController.text,
                                          'email': emailController.text,
                                          'password': passController.text,
                                          'phone': numberController.text,
                                          'address': addresseController.text
                                        };
                                        LoginCubit.get(context).registerUser(
                                            data: sendinfoagence,
                                            path: REGISTERAGENCE);
                                      }
                                    },
                                    child: const Text(
                                      'SIGN UP',
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
                              'You already have account ?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                                onPressed: () {
                                  Changepage(context, LoginScreen());
                                },
                                child: const Text('Login'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is RegisterSuccesState) {
          if (state.model is RegisterModel) {
            CachHelper.putcache(key: 'token', value: state.model!.token)
                .then((value) async {
              await CachHelper.putcache(key: 'userType', value: LOGINAGENCE);
              CupitHome.get(context).currentindex = 0;

              CupitHome.get(context).getOfferAgence();
              CupitHome.get(context).getinformationAgenceOrClient();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            }).then((value) {
              Fluttertoast.showToast(
                  msg:
                      'Successfully Registered \n welcome ${state.model.user.name}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          } else if (state.model is ErrorRegisterAndLoginModel) {
            Fluttertoast.showToast(
                msg: state.model!.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else if (state is RegisterBadState) {
          Fluttertoast.showToast(
              msg: "Unable to connect",
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
