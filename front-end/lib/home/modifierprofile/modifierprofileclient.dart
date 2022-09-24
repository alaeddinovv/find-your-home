import 'dart:convert';
import 'dart:io';

import 'package:agence/clienthome/navbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/components.dart';
import 'package:agence/home/cubitHome/CubitHome.dart';
import 'cubitmodifier.dart';
import 'modifierstate.dart';

class Modifierprofileclient extends StatefulWidget {
  Modifierprofileclient({Key? key}) : super(key: key);

  @override
  State<Modifierprofileclient> createState() => _ModifierprofileclientState();
}

class _ModifierprofileclientState extends State<Modifierprofileclient> {
  CupitHome? objHome;
  CubitModifier? objModifier;
  var namemodController = TextEditingController();
  var prenommodController = TextEditingController();

  // var addressemodControllerr = new TextEditingController(text: 'constantine');
  var numbermodController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Map<String, dynamic> sendinfoclientmodifier = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objHome = BlocProvider.of(context);
    objModifier = BlocProvider.of(context);
    namemodController =
        TextEditingController(text: objHome?.getinfouserModel!.name);
    prenommodController =
        TextEditingController(text: objHome!.getinfouserModel!.client!.prenom);
    numbermodController =
        TextEditingController(text: objHome!.getinfouserModel!.phone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitModifier, ModifierStates>(
      builder: (BuildContext context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  CupitHome.get(context).currentindex = 2;
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.arrow_back),
              ),
              elevation: 10,
              title: Text('Modifier Profile',
                  style: Theme.of(context).textTheme.headline4),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: CubitModifier.get(context)
                                    .selectedImageclient ==
                                null
                            ? (CupitHome.get(context).getinfouserModel!.photo ==
                                    null
                                ? const AssetImage(
                                    'assets/images/profile_avatar.jpg')
                                : Image.memory(
                                    base64Decode(CupitHome.get(context)
                                        .getinfouserModel!
                                        .photo!),
                                    fit: BoxFit.cover,
                                  ).image)
                            : Image.file(File(CubitModifier.get(context)
                                    .selectedImageclient!
                                    .path))
                                .image,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'veuillez choisir une option',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            CubitModifier.get(context)
                                                .selectimagecameramodifierclient();
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.camera_alt,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Camera',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            CubitModifier.get(context)
                                                .selectImagesGalerymodifierclient();
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.image,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Galery',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: const Text(
                            'Ajouter photo',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          )),
                      const SizedBox(
                        height: 14,
                      ),
                      defaultForm(
                          context: context,
                          controller: namemodController,
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
                        height: 22,
                      ),
                      defaultForm(
                          context: context,
                          controller: prenommodController,
                          type: TextInputType.text,
                          lable: Text(
                            'prenom',
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
                            Icons.person,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 22,
                      ),
                      defaultForm(
                        context: context,
                        controller: numbermodController,
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
                        height: 26,
                      ),
                      ConditionalBuilder(
                        condition: state is! ModifierConditionalLodinState,
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
                                      sendinfoclientmodifier = {
                                        'name': namemodController.text,
                                        'phone': numbermodController.text,
                                        'prenom': prenommodController.text,
                                        'photo': CubitModifier.get(context)
                                            .base64Client
                                      };
                                      objModifier!
                                          .updateClient(sendinfoclientmodifier);
                                    }
                                  },
                                  child: const Text(
                                    'MODIFIER',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GoodUpdateClientInfoState) {
          CupitHome.get(context).getinformationAgenceOrClient().then((value) {
            CubitModifier.get(context).selectimageClientnull();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Navbar()),
                (route) => false);
            Fluttertoast.showToast(
                msg: 'Updated Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        } else if (state is BadUpdateClientInfoState) {
          Fluttertoast.showToast(
              msg: 'unable to update',
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
