import 'dart:convert';
import 'dart:io';
import 'package:agence/home/addphoto/editphoto.dart';

import 'package:agence/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubitHome/CubitHome.dart';
import '../cubitHome/homeStates.dart';

class Addphoto extends StatelessWidget {
  Addphoto({Key? key}) : super(key: key);
  Map<String, dynamic> sendinfoOffer = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () {
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
                                    CupitHome.get(context).selectimagecamera();
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
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    CupitHome.get(context).selectImagesGalery();
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
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.black
                                : Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0, 10))
                      ],
                      color: CupitHome.get(context).dartSwitch
                          ? Color(0xff131313)
                          : Colors.grey[200],
                    ),
                    height: 500,
                    width: 350,
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(
                        Icons.add_to_drive,
                        size: 90,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Transferer les images',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Selectionner ou glisser-deplacer les images depuis votre apparail',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  CupitHome.get(context).imageFileList!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),
                              itemBuilder: (BuildContext context, int index) {
                                return Image.file(
                                  File(CupitHome.get(context)
                                      .imageFileList![index]
                                      .path),
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPhoto()));
                          },
                          icon: Icon(Icons.edit),
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.white
                              : Colors.red,
                        ),
                      ])
                    ]),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false);
                          CupitHome.get(context).resetValuePhoto();
                        },
                        child: const Text('RETOUR')),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          if (CupitHome.get(context).base64List.isNotEmpty) {
                            sendinfoOffer = {
                              'type_vente':
                                  CupitHome.get(context).appartementvalueDrop,
                              'address':
                                  CupitHome.get(context).addressController.text,
                              'description': CupitHome.get(context)
                                  .descriptionController
                                  .text,
                              'price':
                                  CupitHome.get(context).priceController.text,
                              'space': CupitHome.get(context)
                                  .superficieController
                                  .text,
                              'n_etage':
                                  CupitHome.get(context).nEtageController.text,
                              'n_chambre':
                                  CupitHome.get(context).nChambres.text,
                              'wilaya':
                                  CupitHome.get(context).wilayavalueDropdown,
                              'photo':
                                  jsonEncode(CupitHome.get(context).base64List),
                              'type_offer':
                                  CupitHome.get(context).vendevalueDrop,
                              'condition_de_paiment': jsonEncode(
                                  CupitHome.get(context).conditionsListhttp),
                              'specification': jsonEncode(
                                  CupitHome.get(context).specificationListhttp),
                              'papiers': jsonEncode(
                                  CupitHome.get(context).papiersListhttp),
                              'latitude':
                                  '${CupitHome.get(context).currentLocation!.latitude}',
                              'longitude':
                                  '${CupitHome.get(context).currentLocation!.longitude}'
                            };
                            CupitHome.get(context)
                                .ajouteroffre(data: sendinfoOffer)
                                .then((value) {
                              CupitHome.get(context).resetValueoffer();
                              CupitHome.get(context).resetValuePhoto();
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'The offer\'s image is required',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text('CONFIRMER'))
                  ],
                ),
              ),
            )
          ]),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is CreateOfferSuccessState) {
          CupitHome.get(context).getOfferAgence().then((value) {
            CupitHome.get(context).currentindex = 0;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
          });
          Fluttertoast.showToast(
              msg: 'offer added successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is CreateOfferBadState) {
          Fluttertoast.showToast(
              msg: 'unable to add the offer',
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
