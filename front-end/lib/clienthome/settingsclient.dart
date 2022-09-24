import 'dart:convert';

import 'package:agence/home/modifierprofile/modifierpasswordclient.dart';
import 'package:agence/home/modifierprofile/modifierprofileclient.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../home/cubitHome/CubitHome.dart';
import '../home/cubitHome/homeStates.dart';

import '../Api/constApi.dart';

import '../home/modifierprofile/cubitmodifier.dart';
import '../login/login.dart';
import '../login/other/cachhelper.dart';
import '../offersdetails/cubitOfferDetail.dart';

class Settingsclient extends StatelessWidget {
  Settingsclient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
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
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: CupitHome.get(context)
                                          .getinfouserModel!
                                          .photo ==
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
                          ]),
                      const SizedBox(
                        height: 9,
                      ),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    var navigationResultClent =
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Modifierprofileclient()));
                                    if (navigationResultClent == true) {
                                      CubitModifier.get(context)
                                          .selectimageClientnull();
                                      // print('ook');
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
                                                Modifierpasswordclient()));
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
                              Icons.person,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${CupitHome.get(context).getinfouserModel!.name}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
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
                              Icons.person,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${CupitHome.get(context).getinfouserModel!.client!.prenom}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
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
                      const Spacer(),
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
                          condition: state is! ConditionalLodinLogoutState,
                          fallback: (BuildContext context) {
                            return const Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
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
            // CupitHome.get(context).dataOfferModel = null;
            CupitHome.get(context).getinfouserModel = null;
            CupitHome.get(context).allofferModel = null;
            CubitDetail.get(context).getFavoritesmodel = null;
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
