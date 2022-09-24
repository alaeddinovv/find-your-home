import 'dart:convert';

import 'package:agence/Api/constApi.dart';
import 'package:agence/home/cubitHome/modifierprofileagence.dart';

import 'package:agence/login/other/cachhelper.dart';
import 'package:agence/offersdetails/cubitOfferDetail.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../login/login.dart';

import 'package:agence/home/cubitHome/CubitHome.dart';
import 'package:agence/home/cubitHome/homeStates.dart';
import 'modifierprofile/cubitmodifier.dart';
import 'modifierprofile/modifierpasswordagence.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 10,
            title: Text(
              'Profile',
              style: TextStyle(
                  color: CupitHome.get(context).dartSwitch
                      ? Colors.white
                      : Colors.black,
                  fontSize: 34),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    CupitHome.get(context).changeSwitch(
                        value: !CupitHome.get(context).dartSwitch);
                  },
                  icon: const Icon(
                    Icons.dark_mode_outlined,
                    size: 30,
                  )),
            ],
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            CupitHome.get(context).getinfouserModel!.photo ==
                                    null
                                ? const AssetImage(
                                    'assets/images/profile_avatar.jpg')
                                : Image.memory(
                                    base64Decode(CupitHome.get(context)
                                        .getinfouserModel!
                                        .photo!),
                                    fit: BoxFit.cover,
                                  ).image,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    var navigationResultAgence =
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Modifierprofile()));
                                    if (navigationResultAgence == true) {
                                      CubitModifier.get(context)
                                          .selectimageAgencenull();
                                    }
                                  },
                                  child: const Text(
                                    'Modifier profile',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                '/',
                                style: TextStyle(
                                  color: CupitHome.get(context).dartSwitch
                                      ? Colors.blueGrey
                                      : Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Modifierpassword()));
                                  },
                                  child: const Text(
                                    'Modifier password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ]),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.real_estate_agent_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfouserModel!.name}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfouserModel!.agence!.address}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            // SizedBox(width: 10,)
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfouserModel!.phone}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.alternate_email,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${CupitHome.get(context).getinfouserModel!.email}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        child: ConditionalBuilder(
                          builder: (BuildContext context) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 46,
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
                                      CupitHome.get(context).logOut();
                                    },
                                    child: const Text(
                                      'DÉCONNEXION',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          condition:
                              // CupitHome.get(context).getinfouserModel != null,
                              state is! ConditionalLodinLogoutState,
                          fallback: (BuildContext context) {
                            return const Align(
                              alignment: Alignment.bottomCenter,
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ]),
              );
            },
            condition: CupitHome.get(context).getinfouserModel != null &&
                state is! ConditionalLodinInfoState,
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is LougOutSuccesState) {
          CachHelper.removdata(key: 'token').then((value) async {
            await CachHelper.removdata(key: 'userType');
            print(TOKEN);
            TOKEN = '';
            CupitHome.get(context).offerAgencModel = null;
            CubitDetail.get(context).getFavoritesmodel = null;
            CupitHome.get(context).allofferModel = null;
            CupitHome.get(context).getinfouserModel = null;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          });
          Fluttertoast.showToast(
              msg: 'déconnexion réussie',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is LougOutBadState) {
          Fluttertoast.showToast(
              msg: 'There\'s a problem',
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
